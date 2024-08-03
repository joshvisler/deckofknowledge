import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cards_repository/cards_repository.dart';
import 'package:flutter/widgets.dart';

import 'package:cards_api/cards_api.dart';
import 'package:myapp/app/app.dart';
import 'package:myapp/app/app_bloc_observer.dart';

void bootstrap({required CardsApi cardsApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final cardsRepository = CardsRepository(cardsApi: cardsApi);

  runZonedGuarded(
    () => runApp(App(cardsRepository: cardsRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
