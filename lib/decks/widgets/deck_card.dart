import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:myapp/decks/view/deck_page.dart';

class DeckCard extends StatelessWidget {
  final DeckModel deck;
  const DeckCard({super.key, required this.deck});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => Dialog.fullscreen(
                  child: DeckPage(
                deck: deck,
              )),
            ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.style,
                      size: 36,
                      color: Colors.white,
                    )),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deck.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('${deck.cardsNumber} Cards, '),
                        Text('${deck.dialogsNumber} Dialogs, '),
                        Text('${deck.storiesNumber} Stories')
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
