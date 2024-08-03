import 'package:flutter/material.dart';
import 'package:myapp/bootstrap.dart';
import 'package:storage_api/cards_storage_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cardsStorage = CardsStorageApi(
    preferences: await SharedPreferences.getInstance(),
  );

  bootstrap(cardsApi: cardsStorage);
}
