part of 'cards_overview_bloc.dart';

enum CardsOverviewStatus { initial, loading, success, failure }

final class CardsOverviewState extends Equatable {
  const CardsOverviewState(
      {this.status = CardsOverviewStatus.initial,
      this.cards = const [],
      this.lastDeletedCard,
      this.currentCardsSwapperIndex = 0
      });

  final List<SplashCardModel> cards;
  final CardsOverviewStatus status;
  final SplashCardModel? lastDeletedCard;
  final int currentCardsSwapperIndex;

  CardsOverviewState copyWith(
      {CardsOverviewStatus Function()? status,
      List<SplashCardModel> Function()? cards,
      SplashCardModel? Function()? lastDeletedCard,
      int Function()? currentCardsSwapperIndex
      }) {
    return CardsOverviewState(
        status: status != null ? status() : this.status,
        cards: cards != null ? cards() : this.cards,
        currentCardsSwapperIndex: currentCardsSwapperIndex != null ? currentCardsSwapperIndex() : this.currentCardsSwapperIndex,
        lastDeletedCard:
            lastDeletedCard != null ? lastDeletedCard() : this.lastDeletedCard);
  }

  @override
  List<Object?> get props => [status, cards, lastDeletedCard, currentCardsSwapperIndex];
}
