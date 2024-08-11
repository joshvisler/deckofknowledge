import 'package:flutter/material.dart';
import 'package:myapp/dialogs_stories_view/models/dialog_story_model.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key, required this.story});

  final DialogStoryModel story;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('StoryView'),
    );
  }
}
