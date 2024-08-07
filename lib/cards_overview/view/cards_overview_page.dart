import 'package:cards_repository/cards_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:myapp/cards_overview/bloc/cards_overview_bloc.dart';
import 'package:myapp/cards_overview/widgets/short_word_card.dart';
import 'package:myapp/edit_word_card/view/create_word_dialog.dart';
import 'package:myapp/l10n/l10n.dart';

class WordCardsOverviewPage extends StatelessWidget {
  const WordCardsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardsOverviewBloc(
        cardsRepository: context.read<CardsRepository>(),
      )..add(const CardsOverviewSubscriptionRequested()),
      child: const CardsOverviewView(),
    );
  }
}

class CardsOverviewView extends StatelessWidget {
  const CardsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
          tooltip: l10n.cardDetailsEditButtonTooltip,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => const Dialog.fullscreen(
                    child: EditWordCard(
                  isCreatingMode: true,
                )),
              ),
          child: const Icon(Icons.add)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CardsOverviewBloc, CardsOverviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
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
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != CardsOverviewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: TextButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          const EditWordCard(isCreatingMode: true),
                    ),
                    child: const Text('Show Dialog'),
                  ),
                );
              }
            }

            final List<Container> cardsWidgets = state.cards.map((card) {
              return Container(
                alignment: Alignment.center,
                child: ShortCard(card: card),
              );
            }).toList();

            if (cardsWidgets.length == 1) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                alignment: Alignment.center,
                child: cardsWidgets[0],
              );
            }

            return CardSwiper(
              cardsCount: cardsWidgets.length,
              allowedSwipeDirection:
                  const AllowedSwipeDirection.only(left: true, right: true),
              cardBuilder:
                  (context, index, percentThresholdX, percentThresholdY) =>
                      cardsWidgets[index],
            );
          },
        ),
      ),
    );
  }
}
