import 'package:flutter/material.dart';
import 'package:myapp/bootstrap.dart';
import 'package:storage_api/storage_api.dart';

void main() async {
  // final apiKey = 'AIzaSyCGK2e06tPThZU0nXV1f14ugAiYxEZ3nnI';
  // final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

  WidgetsFlutterBinding.ensureInitialized();

  final cardsStorage = CardsStorageApi(
    preferences: await SharedPreferences.getInstance(),
  );

  bootstrap(cardsApi: cardsStorage);
}
