import 'dart:async';
import 'dart:developer';

import 'package:decks_repository/decks_repository.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myapp/app/app.dart';
import 'package:myapp/app/app_bloc_observer.dart';

void bootstrap(
    {required CardsApi cardsApi,
    required DecksApi decksApi,
    required StoriesApi storiesApi,
    required DialogsApi dialogsApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final cardsRepository = CardsRepository(cardsApi: cardsApi);
  final decksRepository = DecksRepository(decksApi: decksApi);
  final dialogsRepository = DialogsRepository(dialogsApi: dialogsApi);
  final storiesRepository = StoriesRepository(storiesApi: storiesApi);

  final geminiRepository = GeminiRepository(
      model: GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: 'AIzaSyCGK2e06tPThZU0nXV1f14ugAiYxEZ3nnI'));

  runZonedGuarded(
    () => runApp(App(
        cardsRepository: cardsRepository,
        geminiRepository: geminiRepository,
        decksRepository: decksRepository,
        dialogsRepository: dialogsRepository,
        storiesRepository: storiesRepository
        )),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
