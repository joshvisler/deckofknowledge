import 'package:flutter_test/flutter_test.dart';
import 'package:read_api/read_api.dart';

class TestReadApi extends ReadApi {
  TestReadApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('ReadApi', () {
    test('can be constructed', () {
      expect(TestReadApi.new, returnsNormally);
    });
  });
}
