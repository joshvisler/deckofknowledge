part of 'cards_overview_bloc.dart';

sealed class CardsOverviewEvent extends Equatable {
  const CardsOverviewEvent();

  @override
  List<Object> get props => [];
}

final class CardsOverviewInitial extends CardsOverviewEvent {
  const CardsOverviewInitial();
}

final class CardsOverviewDeleted extends CardsOverviewEvent {
  const CardsOverviewDeleted(this.card);

  final SplashCardModel card;

  @override
  List<Object> get props => [card];
}

final class CardsOverviewUndoDeletionRequested extends CardsOverviewEvent {
  const CardsOverviewUndoDeletionRequested();
}

final class CardsOverviewSwaped extends CardsOverviewEvent {
  const CardsOverviewSwaped(this.index);

  final int index;
}
