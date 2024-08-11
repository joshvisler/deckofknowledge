import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:myapp/decks/bloc/decks_bloc.dart';
import 'package:myapp/decks/view/decks_page.dart';
import 'package:myapp/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App(
      {required this.cardsRepository,
      required this.geminiRepository,
      required this.decksRepository,
      required this.dialogsRepository,
      required this.storiesRepository,
      super.key});

  final CardsRepository cardsRepository;
  final DecksRepository decksRepository;
  final StoriesRepository storiesRepository;
  final DialogsRepository dialogsRepository;
  final GeminiRepository geminiRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: cardsRepository),
        RepositoryProvider.value(value: geminiRepository),
        RepositoryProvider.value(value: decksRepository),
        RepositoryProvider.value(value: storiesRepository),
        RepositoryProvider.value(value: dialogsRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: DecksPage(),
    );
  }
}
