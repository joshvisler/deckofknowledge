import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/cards_overview/view/cards_overview_page.dart';
import 'package:myapp/decks/bloc/decks_bloc.dart';
import 'package:myapp/dialogs_stories_view/view/dialogs_stories_view.dart';
import 'package:myapp/dialogs_stories_view/widgets/create_text_dialog.dart';
import 'package:myapp/edit_word_card/view/create_word_dialog.dart';

class DeckPage extends StatelessWidget {
  const DeckPage({super.key, required this.deck});

  final DeckModel deck;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DecksBloc(
        decksRepository: context.read<DecksRepository>(),
      )..add(const DecksInitial()),
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
        child: BlocConsumer<DecksBloc, DecksState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                  floatingActionButton: FloatingActionButton.small(
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => state
                                        .currentTab ==
                                    TabType.cards
                                ? EditWordCard(
                                    isCreatingMode: true,
                                    deckId: deck.id,
                                  )
                                : Dialog.fullscreen(child: CreateTextDialog()),
                          ),
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
                      DialogsStoriesView(deckId: deck.id),
                    ],
                  ));
            }));
  }
}
