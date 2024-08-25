import 'package:flutter/material.dart';
import 'package:myapp/dialogs_stories_view/models/dialog_story_model.dart';
import 'package:myapp/dialogs_stories_view/widgets/dialog_card.dart';
import 'package:collection/collection.dart';

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
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Expanded(
                child: ListView(
                    children: dialog.text
                        .mapIndexed((index, d) => DialogCard(
                              text: d,
                              translate: dialog.translate[index],
                              isLeftSide: index % 2 == 0,
                            ))
                        .toList()))));
  }
}
