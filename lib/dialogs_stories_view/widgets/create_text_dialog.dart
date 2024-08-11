import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:myapp/dialogs_stories_view/bloc/dialogs_stories_view_bloc.dart';
import 'package:myapp/dialogs_stories_view/models/dialog_story_model.dart';

class CreateTextDialog extends StatelessWidget {
  const CreateTextDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DialogsStoriesViewBloc(
              dialogsRepository: context.read<DialogsRepository>(),
              storiesRepository: context.read<StoriesRepository>(),
              geminiRepository: context.read<GeminiRepository>(),
            ),
        child: Dialog.fullscreen(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Create Text'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: BlocListener<DialogsStoriesViewBloc, DialogsStoriesViewState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == DialogsStoriesViewStatus.success) {
                  Navigator.of(context).pop();
                }
                if (state.status == DialogsStoriesViewStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Error occured'),
                      ),
                    );
                }
              },
              child:
                  BlocBuilder<DialogsStoriesViewBloc, DialogsStoriesViewState>(
                builder: (context, state) {
                  return Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter a search term',
                              ),
                              onChanged: (value) => context
                                  .read<DialogsStoriesViewBloc>()
                                  .add(DialogsStoriesThemeChanged(
                                    value,
                                  )),
                            ),
                            ListTile(
                                title: const Text('Dialog'),
                                leading: Radio<TextType>(
                                  value: TextType.dialog,
                                  onChanged: (TextType? value) => context
                                      .read<DialogsStoriesViewBloc>()
                                      .add(DialogsStoriesTypeChanged(value!)),
                                  groupValue: state.selectedType,
                                )),
                            ListTile(
                                title: const Text('Story'),
                                leading: Radio<TextType>(
                                  value: TextType.story,
                                  onChanged: (TextType? value) => context
                                      .read<DialogsStoriesViewBloc>()
                                      .add(DialogsStoriesTypeChanged(value!)),
                                  groupValue: state.selectedType,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Center(
                                    child: FilledButton(
                                        onPressed: () => state.theme.isEmpty
                                            ? null
                                            : context
                                                .read<DialogsStoriesViewBloc>()
                                                .add(DialogsStoriesGenerate(
                                                    state.selectedType,
                                                    state.theme)),
                                        child: const Text('Save'))))
                          ]));
                },
              ),
            ),
          ),
        ));
  }
}
