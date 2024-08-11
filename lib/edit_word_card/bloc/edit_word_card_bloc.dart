import 'dart:developer';

import 'package:decks_repository/decks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';

part 'edit_word_card_event.dart';
part 'edit_word_card_state.dart';

class EditWordCardBloc extends Bloc<EditWordCardEvent, EditWordCardState> {
  EditWordCardBloc(
      {required CardsRepository cardsRepository,
      required GeminiRepository geminiRepository})
      : _cardsRepository = cardsRepository,
        _geminiRepository = geminiRepository,
        super(const EditWordCardState()) {
    on<EditWordCardSubscriptionRequested>(_onSubscriptionRequested);
    on<EditWordCardGenerateCard>(_onGenerateCard);
    on<EditWordCardSave>(_onCardSave);
    on<EditWordEnterWord>(_onWordUpdated);
  }

  final CardsRepository _cardsRepository;
  final GeminiRepository _geminiRepository;

  Future<void> _onSubscriptionRequested(
    EditWordCardSubscriptionRequested event,
    Emitter<EditWordCardState> emit,
  ) async {
    emit(state.copyWith(
        status: () =>
            event.isCreating ? EditCardStatus.initial : EditCardStatus.editing,
        isCreating: () => event.isCreating,
        card: () => event.card));
  }

  Future<void> _onGenerateCard(
    EditWordCardGenerateCard event,
    Emitter<EditWordCardState> emit,
  ) async {
    emit(state.copyWith(status: () => EditCardStatus.generating));

    var newCard = SplashCardModel(word: state.wordText, deckId: event.deckId);

    await _geminiRepository
        .generateCard(state.wordText)
        .then((wordCard) => {
              newCard = newCard.copyWith(
                  translate: wordCard.translate,
                  examples: wordCard.examples,
                  description: wordCard.description,
                  context: wordCard.context,
                  tags: wordCard.tags),
              _cardsRepository.add(newCard),
              emit(state.copyWith(
                  status: () => EditCardStatus.editing, card: () => newCard))
            })
        .catchError((error) => {
              log(error.toString()),
              emit(state.copyWith(status: () => EditCardStatus.failure))
            });
  }

  Future<void> _onCardSave(
    EditWordCardSave event,
    Emitter<EditWordCardState> emit,
  ) async {
    emit(state.copyWith(status: () => EditCardStatus.saving));

    await _cardsRepository
        .add(state.card!)
        .then((wordCard) =>
            {emit(state.copyWith(status: () => EditCardStatus.success))})
        .catchError((error) =>
            {emit(state.copyWith(status: () => EditCardStatus.failure))});
  }

  Future<void> _onWordUpdated(
    EditWordEnterWord event,
    Emitter<EditWordCardState> emit,
  ) async {
    emit(state.copyWith(
        status: () => EditCardStatus.initial, wordText: () => event.word));
  }
}
