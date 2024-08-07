import 'package:cards_repository/cards_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cards_overview_event.dart';
part 'cards_overview_state.dart';

class CardsOverviewBloc extends Bloc<CardsOverviewEvent, CardsOverviewState> {
  CardsOverviewBloc({required CardsRepository cardsRepository})
      : _cardsRepository = cardsRepository,
        super(const CardsOverviewState()) {
    on<CardsOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<CardsOverviewTodoDeleted>(_onCardDeleted);
    on<CardsOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  final CardsRepository _cardsRepository;

  Future<void> _onSubscriptionRequested(
    CardsOverviewSubscriptionRequested event,
    Emitter<CardsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => CardsOverviewStatus.loading));

    await emit.forEach<List<WordCard>>(
      _cardsRepository.getCards(),
      onData: (cards) => state.copyWith(
        status: () => CardsOverviewStatus.success,
        cards: () => cards,
      ),
      onError: (_, __) => state.copyWith(
        status: () => CardsOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onCardDeleted(
    CardsOverviewTodoDeleted event,
    Emitter<CardsOverviewState> emit,
  ) async {
    emit(state.copyWith(lastDeletedCard: () => event.card));
    await _cardsRepository.deleteCard(event.card.id);

    await emit.forEach<List<WordCard>>(
      _cardsRepository.getCards(),
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
    await _cardsRepository.addCard(todo);
  }
}
