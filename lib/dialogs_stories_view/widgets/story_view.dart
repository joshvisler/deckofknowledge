import 'package:flutter/material.dart';
import 'package:myapp/dialogs_stories_view/models/dialog_story_model.dart';

enum StoryViewType { text, translate }

class StoryView extends StatefulWidget {
  const StoryView({super.key, required this.story});

  final DialogStoryModel story;

  @override
  _StoryViewState createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  late DialogStoryModel story;
  Set<StoryViewType> viewType = [StoryViewType.text].toSet();

  @override
  void initState() {
    super.initState();
    story = widget.story;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(story.theme),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Expanded(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SegmentedButton<StoryViewType>(
                      selected: viewType,
                      onSelectionChanged: (Set<StoryViewType> newSelection) {
                        setState(() {
                          viewType = newSelection;
                        });
                      },
                      segments: const <ButtonSegment<StoryViewType>>[
                        ButtonSegment(
                          label: Text('Original'),
                          value: StoryViewType.text,
                        ),
                        ButtonSegment(
                          label: Text('Translate'),
                          value: StoryViewType.translate,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(viewType.first == StoryViewType.text
                        ? story.text.join(' ')
                        : story.translate.join(' '))
                  ],
                ))));
  }
}
