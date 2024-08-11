import 'package:flutter/material.dart';
import 'package:myapp/dialogs_stories_view/models/dialog_story_model.dart';

class DialogView extends StatelessWidget {
  const DialogView({super.key, required this.dialog});

  final DialogStoryModel dialog;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('DialogView'),
    );
  }
}
