import 'package:cards_repository/cards_repository.dart';
import 'package:flutter/material.dart';

class ShortCard extends StatelessWidget {
  const ShortCard({super.key, required this.card});

  final WordCard card;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            card.word,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const Divider(),
          Text(
            card.translation,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
