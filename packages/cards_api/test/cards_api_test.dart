import 'package:flutter_test/flutter_test.dart';

import 'package:cards_api/src/cards_api.dart';

class TestTodosApi extends CardsApi {
  TestTodosApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('CardsApi', () {
    test('can be constructed', () {
      expect(TestTodosApi.new, returnsNormally);
    });
  });
}
