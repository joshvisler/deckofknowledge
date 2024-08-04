part of 'cards_overview_bloc.dart';

enum CardsOverviewStatus { initial, loading, success, failure }

final class CardsOverviewState extends Equatable {
  const CardsOverviewState(
      {this.status = CardsOverviewStatus.initial,
      this.cards = const [],
      this.lastDeletedCard});

  final List<WordCard> cards;
  final CardsOverviewStatus status;
  final WordCard? lastDeletedCard;

  CardsOverviewState copyWith(
      {CardsOverviewStatus Function()? status,
      List<WordCard> Function()? cards,
      WordCard? Function()? lastDeletedCard}) {
    return CardsOverviewState(
        status: status != null ? status() : this.status,
        cards: cards != null ? cards() : this.cards,
        lastDeletedCard:
            lastDeletedCard != null ? lastDeletedCard() : this.lastDeletedCard);
  }

  @override
  List<Object?> get props => [status, cards, lastDeletedCard];
}
