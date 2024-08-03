import 'dart:convert';

import 'package:cards_api/cards_api.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_api/src/cards_storage_api.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('CardsStorageApi', () {
    late SharedPreferences preferences;

    final Cards = [
      Card(id: '1', word: 'Hallo', translation: 'Hello', context: []),
      Card(id: '2', word: 'Welt', translation: 'World', context: []),
      Card(id: '3', word: 'Test', translation: 'Test', context: []),
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

          expect(subject.getCards(), emits(Cards));
          verify(
            () => preferences.getString(
              CardsStorageApi.kCardsCollectionKey,
            ),
          ).called(1);
        });

        test('with empty list if no Cards present', () {
          when(() => preferences.getString(any())).thenReturn(null);

          final subject = createSubject();

          expect(subject.getCards(), emits(const <Card>[]));
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
        createSubject().getCards(),
        emits(Cards),
      );
    });

    group('saveCard', () {
      test('saves new Cards', () {
        final newCard = Card(
          id: '4',
          word: 'Arbeiten',
          translation: 'Work',
        );

        final newCards = [...Cards, newCard];

        final subject = createSubject();

        expect(subject.addCard(newCard), completes);
        expect(subject.getCards(), emits(newCards));

        verify(
          () => preferences.setString(
            CardsStorageApi.kCardsCollectionKey,
            json.encode(newCards),
          ),
        ).called(1);
      });

      test('updates existing Cards', () {
        final updatedCard = Card(
          id: '1',
          word: 'Hallo',
          translation: 'Hello',
        );
        final newCards = [updatedCard, ...Cards.sublist(1)];

        final subject = createSubject();

        expect(subject.updateCard(updatedCard), completes);
        expect(subject.getCards(), emits(newCards));

        verify(
          () => preferences.setString(
            CardsStorageApi.kCardsCollectionKey,
            json.encode(newCards),
          ),
        ).called(1);
      });
    });

    group('deleteCard', () {
      test('deletes existing Cards', () {
        final newCards = Cards.sublist(1);

        final subject = createSubject();

        expect(subject.deleteCard(Cards[0].id), completes);
        expect(subject.getCards(), emits(newCards));

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
            () => subject.deleteCard('non-existing-id'),
            throwsA(isA<CardNotFoundException>()),
          );
        },
      );
    });
  });
}
