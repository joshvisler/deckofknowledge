import 'dart:developer';

import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:myapp/cards_overview/bloc/cards_overview_bloc.dart';
import 'package:myapp/cards_overview/view/cards_overview_page.dart';
import 'package:myapp/decks/bloc/decks_bloc.dart';
import 'package:myapp/dialogs_stories_view/bloc/dialogs_stories_view_bloc.dart';
import 'package:myapp/dialogs_stories_view/view/dialogs_stories_view.dart';
import 'package:myapp/dialogs_stories_view/widgets/create_text_dialog.dart';
import 'package:myapp/edit_word_card/view/create_word_dialog.dart';

class DeckPage extends StatelessWidget {
  const DeckPage({super.key, required this.deck});

  final DeckModel deck;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DecksBloc(
            decksRepository: context.read<DecksRepository>(),
          )..add(const DecksInitial()),
        ),
        BlocProvider(
            create: (context) => DialogsStoriesViewBloc(
                dialogsRepository: context.read<DialogsRepository>(),
                storiesRepository: context.read<StoriesRepository>(),
                geminiRepository: context.read<GeminiRepository>(),
                deckId: deck.id)
              ..add(const DialogsStoriesViewInitial())),
        BlocProvider(
          create: (context) => CardsOverviewBloc(
            cardsRepository: context.read<CardsRepository>(),
          )..add(const CardsOverviewInitial()),
          child: CardsOverviewView(deckId: deck.id),
        )
      ],
      child: DeckView(
        deck: deck,
      ),
    );
  }
}

class DeckView extends StatelessWidget {
  const DeckView({super.key, required this.deck});

  final DeckModel deck;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: BlocBuilder<DecksBloc, DecksState>(builder: (context, state) {
          return Scaffold(
              floatingActionButton: FloatingActionButton.small(
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  onPressed: () => _showCreateDialog(state.currentTab, context),
                  child: const Icon(Icons.add)),
              appBar: AppBar(
                  title: Text(deck.title),
                  bottom: TabBar(
                    onTap: (tabIndex) =>
                        context.read<DecksBloc>().add(TabChanged(tabIndex)),
                    tabs: const [
                      Tab(
                        text: 'Cards',
                      ),
                      Tab(
                        text: 'Dialogs & Stories',
                      ),
                    ],
                  )),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  WordCardsOverviewPage(deckId: deck.id),
                  DialogsStoriesPage(deckId: deck.id),
                ],
              ));
        }));
  }

  void _showCreateDialog(TabType type, BuildContext parentContext) {
    showDialog(
        context: parentContext,
        builder: (BuildContext context) => type == TabType.cards
            ? BlocProvider<CardsOverviewBloc>.value(
                value: parentContext.read<CardsOverviewBloc>(),
                child: EditWordCard(
                  isCreatingMode: true,
                  deckId: deck.id,
                ))
            : BlocProvider<DialogsStoriesViewBloc>.value(
                value: parentContext.read<DialogsStoriesViewBloc>(),
                child: CreateTextDialog(
                  deckId: deck.id,
                )));
  }
}
