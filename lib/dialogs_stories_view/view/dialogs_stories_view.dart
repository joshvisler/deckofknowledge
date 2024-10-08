import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:myapp/cards_overview/view/cards_overview_page.dart';
import 'package:myapp/dialogs_stories_view/bloc/dialogs_stories_view_bloc.dart';
import 'package:myapp/dialogs_stories_view/widgets/text_card.dart';
import 'package:myapp/dialogs_stories_view/widgets/text_list.dart';

class DialogsStoriesPage extends StatelessWidget {
  const DialogsStoriesPage({super.key, required this.deckId});

  final String deckId;

  @override
  Widget build(BuildContext context) {
    return CardsOverviewView(deckId: deckId);
  }
}

class DialogsStoriesView extends StatelessWidget {
  const DialogsStoriesView({super.key, required this.deckId});

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
