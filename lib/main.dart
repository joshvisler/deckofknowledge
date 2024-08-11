import 'package:flutter/material.dart';
import 'package:myapp/bootstrap.dart';
import 'package:storage_api/storage_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cardsStorage = CardsStorageApi(
    preferences: await SharedPreferences.getInstance(),
  );

  final decksStorage = DecksStorageApi(
    preferences: await SharedPreferences.getInstance(),
  );

  final storiesStorage = StoriesStorageApi(
    preferences: await SharedPreferences.getInstance(),
  );

  final dialogsStorage = DialogsStorageApi(
    preferences: await SharedPreferences.getInstance(),
  );

  bootstrap(
      cardsApi: cardsStorage,
      decksApi: decksStorage,
      storiesApi: storiesStorage,
      dialogsApi: dialogsStorage);
}
