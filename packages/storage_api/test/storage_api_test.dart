import 'dart:convert';

import 'package:decks_repository/decks_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_api/src/cards_storage_api.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('CardsStorageApi', () {
    late SharedPreferences preferences;

    final Cards = [
      SplashCardModel(
          id: '1', deckId: '1', word: 'Hallo', translate: 'Hello', context: []),
      SplashCardModel(
          id: '2', deckId: '1', word: 'Welt', translate: 'World', context: []),
      SplashCardModel(
          id: '3', deckId: '1', word: 'Test', translate: 'Test', context: []),
    ];

    setUp(() {
      preferences = MockSharedPreferences();
      when(() => preferences.getString(any())).thenReturn(json.encode(Cards));
      when(() => preferences.setString(any(), any()))
          .thenAnswer((_) async => true);
    });

    CardsStorageApi createSubject() {
      return CardsStorageApi(
        preferences: preferences,
      );
    }

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });

      group('initializes the Cards stream', () {
        test('with existing Cards if present', () {
          final subject = createSubject();

          expect(subject.get(), emits(Cards));
          verify(
            () => preferences.getString(
              CardsStorageApi.kCardsCollectionKey,
            ),
          ).called(1);
        });

        test('with empty list if no Cards present', () {
          when(() => preferences.getString(any())).thenReturn(null);

          final subject = createSubject();

          expect(subject.get(), emits(const <SplashCardModel>[]));
          verify(
            () => preferences.getString(
              CardsStorageApi.kCardsCollectionKey,
            ),
          ).called(1);
        });
      });
    });

    test('getCards returns stream of current list Cards', () {
      expect(
        createSubject().get(),
        emits(Cards),
      );
    });

    // group('saveCard', () {
    //   test('saves new Cards', () {
    //     final newCard = SplashCardModel(
    //       id: '4',
    //       deckId: '1',
    //       word: 'Arbeiten',
    //       translate: 'Work',
    //     );

    //     final newCards = [...Cards, newCard];

    //     final subject = createSubject();

    //     expect(subject.add(newCard), completes);
    //     expect(subject.get(), emits(newCards));

    //     verify(
    //       () => preferences.setString(
    //         CardsStorageApi.kCardsCollectionKey,
    //         json.encode(newCards),
    //       ),
    //     ).called(1);
    //   });

    //   test('updates existing Cards', () {
    //     final updatedCard = SplashCardModel(
    //       id: '1',
    //       deckId: '1',
    //       word: 'Hallo',
    //       translate: 'Hello',
    //     );
    //     final newCards = [updatedCard, ...Cards.sublist(1)];

    //     final subject = createSubject();

    //     expect(subject.update(updatedCard), completes);
    //     expect(subject.get(), emits(newCards));

    //     verify(
    //       () => preferences.setString(
    //         CardsStorageApi.kCardsCollectionKey,
    //         json.encode(newCards),
    //       ),
    //     ).called(1);
    //   });
    // });

    group('deleteCard', () {
      test('deletes existing Cards', () {
        final newCards = Cards.sublist(1);

        final subject = createSubject();

        expect(subject.delete(Cards[0].id), completes);
        expect(subject.get(), emits(newCards));

        verify(
          () => preferences.setString(
            CardsStorageApi.kCardsCollectionKey,
            json.encode(newCards),
          ),
        ).called(1);
      });

      test(
        'throws CardNotFoundException if Card '
        'with provided id is not found',
        () {
          final subject = createSubject();

          expect(
            () => subject.delete('non-existing-id'),
            throwsA(isA<CardNotFoundException>()),
          );
        },
      );
    });
  });
}
