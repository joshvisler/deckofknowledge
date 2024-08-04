import 'dart:convert';

import 'package:cards_api/cards_api.dart';
import 'package:cards_repository/cards_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCardsApi extends Mock implements CardsApi {}

class FakeCard extends Fake implements WordCard {}

void main() {
  group('CardsRepository', () {
    late CardsApi api;

    final cards = [
      WordCard(id: '1', word: 'Hallo', translation: 'Hello', context: []),
      WordCard(id: '2', word: 'Welt', translation: 'World', context: []),
      WordCard(id: '3', word: 'Test', translation: 'Test', context: []),
    ];

    setUpAll(() {
      registerFallbackValue(FakeCard());
    });

    setUp(() {
      api = MockCardsApi();
      when(() => api.getCards()).thenAnswer((_) => Stream.value(cards));
      when(() => api.addCard(any())).thenAnswer((_) async {});
      when(() => api.deleteCard(any())).thenAnswer((_) async {});
      when(() => api.updateCard(any())).thenAnswer((_) async {});
    });

    CardsRepository createSubject() => CardsRepository(cardsApi: api);

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('getCards', () {
      test('returns stream of current list Cards', () {
        final subject = createSubject();

        expect(
          subject.getCards(),
          isNot(throwsA(anything)),
        );

        verify(() => api.getCards()).called(1);
      });

      test('returns stream of current list cards', () {
        expect(
          createSubject().getCards(),
          emits(cards),
        );
      });
    });

    group('addCard', () {
      test('makes correct api request', () {
        final newCard = WordCard(
          id: '4',
          word: 'Arbeiten',
          translation: 'Work',
        );

        final subject = createSubject();

        expect(subject.addCard(newCard), completes);

        verify(() => api.addCard(newCard)).called(1);
      });
    });

    group('updateCard', () {
      test('makes correct api request', () {
        final card = WordCard(
          id: '1',
          word: 'Calt',
          translation: 'Cold',
        );

        final subject = createSubject();

        expect(subject.addCard(card), completes);

        verify(() => api.addCard(card)).called(1);
      });
    });

    group('deleteCard', () {
      test('makes correct api request', () {
        final subject = createSubject();

        expect(subject.deleteCard(cards[0].id), completes);

        verify(() => api.deleteCard(cards[0].id)).called(1);
      });
    });
  });
}
