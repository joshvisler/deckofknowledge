import 'dart:async';
import 'dart:developer';

import 'package:cards_repository/cards_repository.dart';
import 'package:flutter/widgets.dart';

import 'package:cards_api/cards_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myapp/app/app.dart';
import 'package:myapp/app/app_bloc_observer.dart';

void bootstrap({required CardsApi cardsApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final cardsRepository = CardsRepository(cardsApi: cardsApi);
  final geminiRepository = GeminiRepository(
      model: GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: 'AIzaSyCGK2e06tPThZU0nXV1f14ugAiYxEZ3nnI'));

  runZonedGuarded(
    () => runApp(App(
        cardsRepository: cardsRepository, geminiRepository: geminiRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
