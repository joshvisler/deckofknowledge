import 'package:flutter/material.dart';

class TextList extends StatelessWidget {
  const TextList({required List<Widget> texts, super.key}) : _texts = texts;

  final List<Widget> _texts;

  @override
  Widget build(BuildContext context) {
    if (_texts.isEmpty) {
      return const Expanded(child: Center(child: Text("No texts found")));
    } else {
      return Expanded(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: _texts,
              )));
    }
  }
}
