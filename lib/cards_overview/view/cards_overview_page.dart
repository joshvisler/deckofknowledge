import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:myapp/cards_overview/bloc/cards_overview_bloc.dart';
import 'package:myapp/cards_overview/widgets/short_word_card.dart';
import 'package:myapp/edit_word_card/view/create_word_dialog.dart';
import 'package:myapp/l10n/l10n.dart';

class WordCardsOverviewPage extends StatelessWidget {
  const WordCardsOverviewPage({super.key, required this.deckId});

  final String deckId;

  @override
  Widget build(BuildContext context) {
    return CardsOverviewView(deckId: deckId);
  }
}

class CardsOverviewView extends StatelessWidget {
  const CardsOverviewView({super.key, required this.deckId});

  final String deckId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cardSwiperController = CardSwiperController();

    return MultiBlocListener(
      listeners: [
        BlocListener<CardsOverviewBloc, CardsOverviewState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == CardsOverviewStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(l10n.cardsOverviewErrorSnackbarText),
                  ),
                );
            }
          },
        ),
        BlocListener<CardsOverviewBloc, CardsOverviewState>(
          listenWhen: (previous, current) =>
              previous.lastDeletedCard != current.lastDeletedCard &&
              current.lastDeletedCard != null,
          listener: (context, state) {
            final deletedTodo = state.lastDeletedCard!;
            final messenger = ScaffoldMessenger.of(context);
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    l10n.cardsOverviewcardDeletedSnackbarText(
                      deletedTodo.word,
                    ),
                  ),
                  action: SnackBarAction(
                    label: l10n.cardsOverviewUndoDeletionButtonText,
                    onPressed: () {
                      messenger.hideCurrentSnackBar();
                      context
                          .read<CardsOverviewBloc>()
                          .add(const CardsOverviewUndoDeletionRequested());
                    },
                  ),
                ),
              );
          },
        ),
      ],
      child: BlocBuilder<CardsOverviewBloc, CardsOverviewState>(
        builder: (context, state) {
          if (state.cards.isEmpty) {
            if (state.status == CardsOverviewStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status != CardsOverviewStatus.success) {
              return const SizedBox();
            } else {
              return Column(children: [
                IconButton(
                  icon: const Icon(Icons.download),
                  tooltip: 'Export deck',
                  onPressed: () => context
                      .read<CardsOverviewBloc>()
                      .add(ExportCardsFile(state.cards)),
                ),
                IconButton(
                  icon: const Icon(Icons.upload),
                  tooltip: 'Export deck',
                  onPressed: () => context
                      .read<CardsOverviewBloc>()
                      .add(const RestoreCardsFromFile()),
                ),
                Center(
                  child: TextButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => EditWordCard(
                        isCreatingMode: true,
                        deckId: deckId,
                      ),
                    ),
                    child: const Text('No cards found.'),
                  ),
                )
              ]);
            }
          }

          final List<Widget> cardsWidgets = state.cards.map((card) {
            return ShortCard(
              card: card,
              deckId: deckId,
            );
          }).toList();

          if (cardsWidgets.length == 1) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              alignment: Alignment.center,
              child: cardsWidgets[0],
            );
          }

          return Column(children: [
            IconButton(
              icon: const Icon(Icons.download),
              tooltip: 'Export deck',
              onPressed: () => context
                  .read<CardsOverviewBloc>()
                  .add(ExportCardsFile(state.cards)),
            ),
            IconButton(
              icon: const Icon(Icons.upload),
              tooltip: 'Export deck',
              onPressed: () => context
                  .read<CardsOverviewBloc>()
                  .add(const RestoreCardsFromFile()),
            ),
            Expanded(
                flex: 10,
                child: CardSwiper(
                  cardsCount: state.cards.length,
                  controller: cardSwiperController,
                  onSwipe: (previousIndex, currentIndex, direction) {
                    context
                        .read<CardsOverviewBloc>()
                        .add(CardsOverviewSwaped(currentIndex ?? 0));

                    return true;
                  },
                  allowedSwipeDirection:
                      const AllowedSwipeDirection.only(left: true, right: true),
                  cardBuilder:
                      (context, index, percentThresholdX, percentThresholdY) =>
                          cardsWidgets[index],
                )),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton.filledTonal(
                  color: Color(0xFFF2E6D9),
                  onPressed: () =>
                      cardSwiperController.swipe(CardSwiperDirection.left),
                  icon: Icon(Icons.arrow_left, color: Color(0xFFFFB763))),
              Text(
                  '${state.currentCardsSwapperIndex + 1}/${state.cards.length}'),
              IconButton.filledTonal(
                  color: Color(0xFFF2E6D9),
                  onPressed: () =>
                      cardSwiperController.swipe(CardSwiperDirection.right),
                  icon: Icon(
                    Icons.arrow_right,
                    color: Color(0xFFFFB763),
                  )),
            ]),
            const Spacer(
              flex: 1,
            ),
          ]);
        },
      ),
    );
  }
}
