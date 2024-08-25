import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/decks/bloc/decks_bloc.dart';
import 'package:myapp/utils/languages_picker/widgets/language_picker_dialog.dart';

class CreateDeckDialog extends StatelessWidget {
  const CreateDeckDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DecksBloc(
              decksRepository: context.read<DecksRepository>(),
            ),
        child: Dialog.fullscreen(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Create Deck'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: BlocListener<DecksBloc, DecksState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == DecksViewStatus.success) {
                  Navigator.of(context).pop();
                }
                if (state.status == DecksViewStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Error occured'),
                      ),
                    );
                }
              },
              child: BlocBuilder<DecksBloc, DecksState>(
                builder: (context, state) {
                  return Padding(
                      padding: EdgeInsets.only(
                        top: 24,
                        left: 24,
                        right: 24,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Deck title',
                              ),
                              onChanged: (value) => context
                                  .read<DecksBloc>()
                                  .add(CreateDeckTitleChanged(value)),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Cards language',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FilledButton(
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder:
                                          (BuildContext showDialogContext) =>
                                              BlocProvider.value(
                                                value:
                                                    context.read<DecksBloc>(),
                                                child: LanguagePickerDialog(
                                                    selectedLanguage:
                                                        state.languageFrom,
                                                    onValuePicked: (value) =>
                                                        context
                                                            .read<DecksBloc>()
                                                            .add(
                                                                CreateDeckLanguageFromChanged(
                                                                    value))),
                                              )),
                                  child: Text(state.languageFrom),
                                ),
                                Icon(Icons.swap_horiz),
                                FilledButton(
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder:
                                          (BuildContext showDialogContext) =>
                                              BlocProvider.value(
                                                value:
                                                    context.read<DecksBloc>(),
                                                child: LanguagePickerDialog(
                                                    selectedLanguage:
                                                        state.languageTo,
                                                    onValuePicked: (value) =>
                                                        context
                                                            .read<DecksBloc>()
                                                            .add(
                                                                CreateDeckLanguageToChanged(
                                                                    value))),
                                              )),
                                  child: Text(state.languageTo),
                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Center(
                                    child: FilledButton(
                                        onPressed: state.title.isEmpty
                                            ? null
                                            : () => context
                                                .read<DecksBloc>()
                                                .add(const CreateDeck()),
                                        child: const Text('Save'))))
                          ]));
                },
              ),
            ),
          ),
        ));
  }
}
