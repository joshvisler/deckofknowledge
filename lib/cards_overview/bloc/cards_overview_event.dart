part of 'cards_overview_bloc.dart';

sealed class CardsOverviewEvent extends Equatable {
  const CardsOverviewEvent();

  @override
  List<Object> get props => [];
}

final class CardsOverviewInitial extends CardsOverviewEvent {
  const CardsOverviewInitial(this.deckId);

  final String deckId;
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

final class ExportCardsFile extends CardsOverviewEvent {
  const ExportCardsFile(this.cards);

  final List<SplashCardModel> cards;
}

final class RestoreCardsFromFile extends CardsOverviewEvent {
  const RestoreCardsFromFile();
}
