import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/cards_overview/bloc/cards_overview_bloc.dart';
import 'package:myapp/edit_word_card/view/create_word_dialog.dart';

class ShortCard extends StatelessWidget {
  const ShortCard({super.key, required this.card, required this.deckId});

  final SplashCardModel card;
  final String deckId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => Dialog.fullscreen(
                  child: EditWordCard(
                isCreatingMode: false,
                card: card,
                deckId: deckId,
              )),
            ),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => context
                      .read<CardsOverviewBloc>()
                      .add(CardsOverviewDeleted(card)),
                  icon: Icon(Icons.close)),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Text(
                      card.word,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Divider(),
                    Text(
                      card.translate,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  ]))
            ],
          ),
        ));
  }
}
