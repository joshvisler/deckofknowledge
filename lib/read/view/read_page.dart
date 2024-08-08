import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:myapp/cards_overview/bloc/cards_overview_bloc.dart';
import 'package:myapp/cards_overview/widgets/short_word_card.dart';
import 'package:myapp/edit_word_card/view/create_word_dialog.dart';
import 'package:myapp/l10n/l10n.dart';
import 'package:myapp/read/bloc/read_bloc.dart';
import 'package:read_repository/read_repository.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReadBloc(
        readRepository: context.read<ReadRepository>(),
      )..add(const ReadSubscriptionRequested()),
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
          BlocListener<ReadBloc, ReadState>(
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
        ],
        child: BlocBuilder<ReadBloc, ReadState>(
          builder: (context, state) {
            if (state.dialogs == null) {
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
