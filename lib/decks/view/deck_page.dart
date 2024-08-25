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
              decksRepository: context.read<DecksRepository>(),
            )..add(DialogsStoriesViewInitial(deck.id)),
          ),
          BlocProvider(
            create: (context) => CardsOverviewBloc(
              cardsRepository: context.read<CardsRepository>(),
            )..add(const CardsOverviewInitial()),
          )
        ],
        child: DeckView(
          deck: deck,
        ));
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
            builder: (blocConsumerContext, state) {
              return Scaffold(
                  floatingActionButton: FloatingActionButton(
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext showDialogContext) => state.currentTab ==
                                  TabType.cards
                              ? EditWordCard(
                                  isCreatingMode: true,
                                  deckId: deck.id,
                                )
                              : BlocProvider.value(
                                  value: context.read<DialogsStoriesViewBloc>(),
                                  child: const CreateTextDialog(),
                                )),
                      child: const Icon(Icons.add)),
                  appBar: AppBar(
                      title: Text(deck.title),
                      bottom: TabBar(
                        onTap: (tabIndex) => blocConsumerContext
                            .read<DecksBloc>()
                            .add(TabChanged(tabIndex)),
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
