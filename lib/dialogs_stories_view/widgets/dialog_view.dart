import 'package:flutter/material.dart';
import 'package:myapp/dialogs_stories_view/models/dialog_story_model.dart';
import 'package:collection/collection.dart';
import 'package:myapp/dialogs_stories_view/widgets/dialog_card.dart';

class DialogView extends StatelessWidget {
  const DialogView({super.key, required this.dialog});

  final DialogStoryModel dialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(dialog.theme),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Expanded(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: dialog.text
                .where((t) => !t.contains('Szene'))
                .mapIndexed<Widget>((index, text) => DialogCard(
                      text: text,
                      isLeftSide: index % 2 == 0,
                      translate: dialog.translate[index + 1],
                    ))
                .toList(),
          ),
        )));
  }
}
