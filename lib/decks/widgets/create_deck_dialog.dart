import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/decks/bloc/decks_bloc.dart';

class CreateDeckDialog extends StatelessWidget {
  const CreateDeckDialog({Key? key}) : super(key: key);

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
                      child: Column(children: [
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a search term',
                          ),
                          onChanged: (value) => context
                              .read<DecksBloc>()
                              .add(CreateDeckTitleChanged(value)),
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
