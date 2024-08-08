part of 'cards_overview_bloc.dart';

sealed class CardsOverviewEvent extends Equatable {
  const CardsOverviewEvent();

  @override
  List<Object> get props => [];
}

final class CardsOverviewSubscriptionRequested extends CardsOverviewEvent {
  const CardsOverviewSubscriptionRequested();
}

final class CardsOverviewDeleted extends CardsOverviewEvent {
  const CardsOverviewDeleted(this.card);

  final WordCard card;

  @override
  List<Object> get props => [card];
}

final class CardsOverviewUndoDeletionRequested extends CardsOverviewEvent {
  const CardsOverviewUndoDeletionRequested();
}
