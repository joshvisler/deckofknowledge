import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/decks/bloc/decks_bloc.dart';
import 'package:myapp/decks/widgets/create_deck_dialog.dart';
import 'package:myapp/decks/widgets/deck_card.dart';
import 'package:myapp/decks/widgets/decks_list.dart';

class DecksPage extends StatelessWidget {
  const DecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DecksBloc(
        decksRepository: context.read<DecksRepository>(),
      )..add(const DecksInitial()),
      child: const DecksView(),
    );
  }
}

class DecksView extends StatelessWidget {
  const DecksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => CreateDeckDialog()),
            child: const Icon(Icons.add)),
        body: MultiBlocListener(
            listeners: [
              BlocListener<DecksBloc, DecksState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == DecksViewStatus.failure) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('error'),
                        ),
                      );
                  }
                },
              )
            ],
            child:
                BlocBuilder<DecksBloc, DecksState>(builder: (context, state) {
              if (state.status == DecksViewStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var decks =
                    state.decks.map((deck) => DeckCard(deck: deck)).toList();

                return SafeArea(
                    child: Column(children: [
                  Container(
                    color: const Color(0xFFF2E6D9),
                    height: 200,
                    child: Row(
                      children: [
                        const Image(
                            image: AssetImage('assets/images/man_hello.png')),
                        const SizedBox(
                          width: 24,
                        ),
                        Wrap(children: [
                          Text(
                            '''Hi!

Let’s learn new
words together!''',
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ])
                      ],
                    ),
                  ),
                  DecksList(decks: decks)
                ]));
              }
            })));
  }
}
