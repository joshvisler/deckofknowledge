import 'package:flutter/material.dart';
import 'package:myapp/dialogs_stories_view/models/dialog_story_model.dart';
import 'package:myapp/dialogs_stories_view/widgets/dialog_view.dart';
import 'package:myapp/dialogs_stories_view/widgets/story_view.dart';

class TextCard extends StatelessWidget {
  const TextCard({super.key, required this.text});

  final DialogStoryModel text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => Dialog.fullscreen(
                  child: text.type == TextType.dialog
                      ? DialogView(dialog: text)
                      : StoryView(story: text)),
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
                      text.theme,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${text.type}'),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
