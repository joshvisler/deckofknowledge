import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:myapp/l10n/l10n.dart';

class CreateWordCardDialog extends StatelessWidget {
  const CreateWordCardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    String? _newWord;

    return AlertDialog(
      title: Text(l10n.cardDetailsEditButtonTooltip),
      content: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter a search term',
        ),
        onChanged: (value) => _newWord = value,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            log('new word: $_newWord');
            var card = await context.read<GeminiRepository>().generateCard(_newWord!);
            context.read<GeminiRepository>()

            log(card.toJson().toString());

            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
