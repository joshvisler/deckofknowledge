import 'package:decks_repository/decks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'decks_event.dart';
part 'decks_state.dart';

class DecksBloc extends Bloc<DecksEvent, DecksState> {
  DecksBloc({required DecksRepository decksRepository})
      : _decksRepository = decksRepository,
        super(const DecksState()) {
    on<DecksInitial>(_onInitial);
    on<CreateDeck>(_onCreateDeck);
    on<CreateDeckTitleChanged>(_onCreateDeckTitleChanged);
    on<TabChanged>(_onTabChanged);
  }

  final DecksRepository _decksRepository;

  Future<void> _onInitial(
    DecksInitial event,
    Emitter<DecksState> emit,
  ) async {
    emit(state.copyWith(status: () => DecksViewStatus.loading));

    await emit.forEach<List<DeckModel>>(
      _decksRepository.get(),
      onData: (decks) => state.copyWith(
        status: () => DecksViewStatus.success,
        decks: () => decks,
      ),
      onError: (_, __) => state.copyWith(
        status: () => DecksViewStatus.failure,
      ),
    );
  }

  Future<void> _onCreateDeck(
    CreateDeck event,
    Emitter<DecksState> emit,
  ) async {
    emit(state.copyWith(status: () => DecksViewStatus.loading));

    if (state.title.isEmpty) {
      throw Exception('Name is empty');
    }

    var deck = DeckModel(title: state.title);

    await _decksRepository.add(deck).onError((error, stackTrace) {
      emit(state.copyWith(status: () => DecksViewStatus.failure));
    });

    await emit.forEach<List<DeckModel>>(
      _decksRepository.get(),
      onData: (decks) => state.copyWith(
        status: () => DecksViewStatus.success,
        decks: () => decks,
      ),
      onError: (_, __) => state.copyWith(
        status: () => DecksViewStatus.failure,
      ),
    );
  }

  Future<void> _onCreateDeckTitleChanged(
    CreateDeckTitleChanged event,
    Emitter<DecksState> emit,
  ) async {
    emit(state.copyWith(title: () => event.name));
  }

  Future<void> _onTabChanged(
    TabChanged event,
    Emitter<DecksState> emit,
  ) async {
    emit(state.copyWith(
        currentTab: () => event.index == 0 ? TabType.cards : TabType.texts));
  }
}
