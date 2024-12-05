import 'package:cnpj_flutter_challenge/enums/standard_mode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Standard Mode', () {
    test('defaultValue', () {
      expect(StandardMode.defaultValue, isA<StandardMode>());
      expect(StandardMode.defaultValue, equals(StandardMode.latest));
    });
  });
}
