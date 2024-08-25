import 'package:flutter/material.dart';
import 'package:myapp/dialogs_stories_view/models/dialog_story_model.dart';

enum StoryViewType { text, translate }

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({super.key, required this.story});

  final DialogStoryModel story;

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  Set<StoryViewType> viewType = {StoryViewType.text};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.story.theme),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              SegmentedButton<StoryViewType>(
                  segments: const <ButtonSegment<StoryViewType>>[
                    ButtonSegment<StoryViewType>(
                        value: StoryViewType.text, label: Text('Text')),
                    ButtonSegment<StoryViewType>(
                        value: StoryViewType.translate,
                        label: Text('Translate')),
                  ],
                  selected: viewType,
                  onSelectionChanged: (Set<StoryViewType> newSelection) {
                    setState(() {
                      viewType = newSelection;
                    });
                  }),
              const SizedBox(width: 44),
              Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Expanded(
                      child: SingleChildScrollView(
                    child: Text(viewType.first == StoryViewType.text
                        ? widget.story.text.join('')
                        : widget.story.translate.join('')),
                  )))
            ])));
  }
}
