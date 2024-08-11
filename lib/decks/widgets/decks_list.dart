import 'package:flutter/material.dart';

class DecksList extends StatelessWidget {
  const DecksList({required List<Widget> decks, super.key}) : _decks = decks;

  final List<Widget> _decks;

  @override
  Widget build(BuildContext context) {
    if (_decks.isEmpty) {
      return const Expanded(child: Center(child: Text("No decks found")));
    } else {
      return Expanded(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: _decks,
              )));
    }
  }
}
