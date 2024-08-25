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
                Expanded(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                          overflow: TextOverflow.fade,
                      deck.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          deck.languageFrom,
                          softWrap: true,
                        ),
                        const Icon(
                          Icons.swap_horiz,
                          size: 16,
                        ),
                        Text(
                          deck.languageTo,
                        ),
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
