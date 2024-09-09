import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:decks_repository/decks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

part 'cards_overview_event.dart';
part 'cards_overview_state.dart';

class CardsOverviewBloc extends Bloc<CardsOverviewEvent, CardsOverviewState> {
  CardsOverviewBloc({required CardsRepository cardsRepository})
      : _cardsRepository = cardsRepository,
        super(const CardsOverviewState()) {
    on<CardsOverviewInitial>(_onInitial);
    on<CardsOverviewDeleted>(_onCardDeleted);
    on<CardsOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
    on<RestoreCardsFromFile>(_onRestoreCardsFromFile);
    on<ExportCardsFile>(_onExportCardsFile);
    on<CardsOverviewSwaped>(_onSwaped);
  }

  final CardsRepository _cardsRepository;

  Future<void> _onInitial(
    CardsOverviewInitial event,
    Emitter<CardsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => CardsOverviewStatus.loading));

    await emit.forEach<List<SplashCardModel>>(
      _cardsRepository.get(),
      onData: (cards) => state.copyWith(
        status: () => CardsOverviewStatus.success,
        cards: () => cards.where((c) => c.deckId == event.deckId).toList(),
      ),
      onError: (_, __) => state.copyWith(
        status: () => CardsOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onCardDeleted(
    CardsOverviewDeleted event,
    Emitter<CardsOverviewState> emit,
  ) async {
    emit(state.copyWith(lastDeletedCard: () => event.card));
    await _cardsRepository.delete(event.card.id);

    await emit.forEach<List<SplashCardModel>>(
      _cardsRepository.get(),
      onData: (cards) => state.copyWith(
        status: () => CardsOverviewStatus.success,
        cards: () => cards,
      ),
      onError: (_, __) => state.copyWith(
        status: () => CardsOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onUndoDeletionRequested(
    CardsOverviewUndoDeletionRequested event,
    Emitter<CardsOverviewState> emit,
  ) async {
    assert(
      state.lastDeletedCard != null,
      'Last deleted todo can not be null.',
    );

    final todo = state.lastDeletedCard!;
    emit(state.copyWith(lastDeletedCard: () => null));
    await _cardsRepository.add(todo);
  }

  FutureOr<bool> _onSwaped(
    CardsOverviewSwaped event,
    Emitter<CardsOverviewState> emit,
  ) async {
    emit(state.copyWith(currentCardsSwapperIndex: () => event.index));

    return true;
  }

  Future<void> _onExportCardsFile(
    ExportCardsFile event,
    Emitter<CardsOverviewState> emit,
  ) async {
    if (event.cards.isEmpty) return;

    emit(state.copyWith(status: () => CardsOverviewStatus.loading));

    final downloadPath = '/storage/emulated/0/Download/';

    
    if(!Directory('${downloadPath}/deckofknowledge/').existsSync())
      Directory('${downloadPath}/deckofknowledge/').createSync();

    var file = File('${downloadPath}/deckofknowledge/cards.json');
    file.createSync();

    file.writeAsStringSync(jsonEncode(event.cards));

    emit(state.copyWith(status: () => CardsOverviewStatus.success));
  }

  Future<void> _onRestoreCardsFromFile(
    RestoreCardsFromFile event,
    Emitter<CardsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => CardsOverviewStatus.loading));

    final downloadPath = await getApplicationDocumentsDirectory();

    FilePickerResult? result = await FilePicker.platform
        .pickFiles(initialDirectory: downloadPath!.path);

    if (result != null) {
      File file = File(result.files.single.path!);

      final cardsJson = await file.readAsString();

      final cards = List<Map<dynamic, dynamic>>.from(
        json.decode(cardsJson) as List,
      )
          .map((jsonMap) =>
              SplashCardModel.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();

      cards.forEach((card) async => await _cardsRepository.add(card));

      await emit.forEach<List<SplashCardModel>>(
        _cardsRepository.get(),
        onData: (decks) => state.copyWith(
          status: () => CardsOverviewStatus.success,
          cards: () => decks,
        ),
        onError: (_, __) => state.copyWith(
          status: () => CardsOverviewStatus.failure,
        ),
      );
    } else {
      emit(state.copyWith(status: () => CardsOverviewStatus.success));
    }
  }
}
