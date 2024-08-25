import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:myapp/dialogs_stories_view/bloc/dialogs_stories_view_bloc.dart';
import 'package:myapp/dialogs_stories_view/widgets/text_card.dart';
import 'package:myapp/dialogs_stories_view/widgets/text_list.dart';

class DialogsStoriesView extends StatelessWidget {
  const DialogsStoriesView({super.key, required this.deckId});

  final String deckId;

  @override
  Widget build(BuildContext context) {
    return CardsOverviewView(deckId: deckId);
  }
}

class CardsOverviewView extends StatelessWidget {
  const CardsOverviewView({super.key, required this.deckId});

  final String deckId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DialogsStoriesViewBloc, DialogsStoriesViewState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == DialogsStoriesViewStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('error'),
                  ),
                );
            }
          },
        ),
      ],
      child: BlocBuilder<DialogsStoriesViewBloc, DialogsStoriesViewState>(
        builder: (context, state) {
          // if (state.texts.isEmpty) {
          //   if (state.status == DialogsStoriesViewStatus.loading) {
          //     return const Center(child: CircularProgressIndicator());
          //   } else if (state.status != DialogsStoriesViewStatus.success) {
          //     return const SizedBox();
          //   } else {
          //     return Center(
          //       child: TextButton(
          //         onPressed: () => showDialog<String>(
          //           context: context,
          //           builder: (BuildContext context) => EditWordCard(
          //             isCreatingMode: true,
          //             deckId: deckId,
          //           ),
          //         ),
          //         child: const Text('No cards found.'),
          //       ),
          //     );
          //   }
          // }

          final List<Widget> texts = state.texts.map((text) {
            return TextCard(
              text: text,
            );
          }).toList();

          return TextList(texts: texts);
        },
      ),
    );
  }
}
