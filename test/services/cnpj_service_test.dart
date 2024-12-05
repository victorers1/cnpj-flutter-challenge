import 'package:cnpj_flutter_challenge/enums/standard_mode.dart';
import 'package:cnpj_flutter_challenge/services/cnpj_service.dart';
import 'package:flutter_test/flutter_test.dart';

final cnpjService = CnpjService();

void main() {
  group('CnpjService', () {
    test('digitToInt', () {
      const String empty = '';
      const String zero = '0';
      const String nine = '9';
      const String a = 'a';
      const String z = 'z';
      const String A = 'A';
      const String Z = 'Z';
      const String char = '.';

      final zeroResult = cnpjService.digitToInt(zero);
      final nineResult = cnpjService.digitToInt(nine);
      final aUppercaseResult = cnpjService.digitToInt(A);
      final zUppercaseResult = cnpjService.digitToInt(Z);

      expect(zeroResult, equals(0));
      expect(nineResult, equals(9));
      expect(() => cnpjService.digitToInt(a), throwsA(isA<RangeError>()));
      expect(() => cnpjService.digitToInt(z), throwsA(isA<RangeError>()));
      expect(aUppercaseResult, equals(17));
      expect(zUppercaseResult, equals(42));
      expect(() => cnpjService.digitToInt(empty), throwsA(isA<RangeError>()));
      expect(() => cnpjService.digitToInt(char), throwsA(isA<RangeError>()));
    });

    test('getDV', () {
      const cnpj1 = '092418650001';
      const cnpj2 = '639916590001';
      const cnpj3 = '036722360001';
      const cnpj4 = '614898910001';
      const cnpj5 = '014916100001';

      final cnpj1Result = cnpjService.calcDV(cnpj1);
      final cnpj2Result = cnpjService.calcDV(cnpj2);
      final cnpj3Result = cnpjService.calcDV(cnpj3);
      final cnpj4Result = cnpjService.calcDV(cnpj4);
      final cnpj5Result = cnpjService.calcDV(cnpj5);

      expect(cnpj1Result, equals('14'));
      expect(cnpj2Result, equals('77'));
      expect(cnpj3Result, equals('62'));
      expect(cnpj4Result, equals('86'));
      expect(cnpj5Result, equals('06'));
    });

    test('getFirstDV', () {
      const cnpj1 = '092418650001';
      const cnpj2 = '639916590001';
      const cnpj3 = '036722360001';
      const cnpj4 = '614898910001';
      const cnpj5 = '014916100001';

      final cnpj1Result = cnpjService.calcFirstDV(cnpj1);
      final cnpj2Result = cnpjService.calcFirstDV(cnpj2);
      final cnpj3Result = cnpjService.calcFirstDV(cnpj3);
      final cnpj4Result = cnpjService.calcFirstDV(cnpj4);
      final cnpj5Result = cnpjService.calcFirstDV(cnpj5);

      expect(cnpj1Result, equals('1'));
      expect(cnpj2Result, equals('7'));
      expect(cnpj3Result, equals('6'));
      expect(cnpj4Result, equals('8'));
      expect(cnpj5Result, equals('0'));
    });

    test('getSecondDV', () {
      const cnpj1 = '0924186500011';
      const cnpj2 = '6399165900017';
      const cnpj3 = '0367223600016';
      const cnpj4 = '6148989100018';
      const cnpj5 = '0149161000010';

      final cnpj1Result = cnpjService.calcSecondDV(cnpj1);
      final cnpj2Result = cnpjService.calcSecondDV(cnpj2);
      final cnpj3Result = cnpjService.calcSecondDV(cnpj3);
      final cnpj4Result = cnpjService.calcSecondDV(cnpj4);
      final cnpj5Result = cnpjService.calcSecondDV(cnpj5);

      expect(cnpj1Result, equals('4'));
      expect(cnpj2Result, equals('7'));
      expect(cnpj3Result, equals('2'));
      expect(cnpj4Result, equals('6'));
      expect(cnpj5Result, equals('6'));
    });

    test('validate: Field is mandatory', () {
      expect(cnpjService.validate(null), equals('Field is mandatory'));
    });

    test('validate: Insufficient characters', () {
      const cnpj1 = '';
      const cnpj2 = '639916590001';
      const cnpj3 = '03672236000';
      const cnpj4 = '6148989100';

      final cnpj1Result = cnpjService.validate(cnpj1);
      final cnpj2Result = cnpjService.validate(cnpj2);
      final cnpj3Result = cnpjService.validate(cnpj3);
      final cnpj4Result = cnpjService.validate(cnpj4);

      expect(cnpj1Result, equals('Insufficient characters'));
      expect(cnpj2Result, equals('Insufficient characters'));
      expect(cnpj3Result, equals('Insufficient characters'));
      expect(cnpj4Result, equals('Insufficient characters'));
    });

    test('validate: Too many characters', () {
      const cnpj1 = '092418650001111';
      const cnpj2 = '6399165900017123';
      const cnpj3 = '03672236000161234';

      final cnpj1Result = cnpjService.validate(cnpj1);
      final cnpj2Result = cnpjService.validate(cnpj2);
      final cnpj3Result = cnpjService.validate(cnpj3);

      expect(cnpj1Result, equals('Too many characters'));
      expect(cnpj2Result, equals('Too many characters'));
      expect(cnpj3Result, equals('Too many characters'));
    });

    test('validate: Input contains invalid characters', () {
      const startsWithInvalid = ';9241865000112';
      const endsWithInvalid = '6399165900012!';
      const containsInvalid = '03672@36000112';
      const allInvalid = '!@#\$%&*()_+/12';
      const lowercase = 'a2312312312312';

      final startsWithInvalidResult = cnpjService.validate(
        startsWithInvalid,
      );
      final endsWithInvalidResult = cnpjService.validate(endsWithInvalid);
      final containsInvalidResult = cnpjService.validate(containsInvalid);
      final allInvalidResult = cnpjService.validate(allInvalid);
      final lowercaseResult = cnpjService.validate(lowercase);

      expect(
        startsWithInvalidResult,
        equals('Input contains invalid characters'),
      );
      expect(
        endsWithInvalidResult,
        equals('Input contains invalid characters'),
      );
      expect(
        containsInvalidResult,
        equals('Input contains invalid characters'),
      );
      expect(allInvalidResult, equals('Input contains invalid characters'));
      expect(lowercaseResult, equals('Input contains invalid characters'));
    });

    test('validate: All characters are the same', () {
      const cnpj1 = '11111111111111';
      const cnpj2 = '22222222222222';
      const cnpj3 = '33333333333333';
      const cnpj4 = '44444444444444';
      const cnpj5 = '55555555555555';
      const cnpj6 = '66666666666666';
      const cnpj7 = '77777777777777';
      const cnpj8 = '88888888888888';
      const cnpj9 = '99999999999999';
      const cnpj0 = '00000000000000';

      final cnpj1Result = cnpjService.validate(cnpj1);
      final cnpj2Result = cnpjService.validate(cnpj2);
      final cnpj3Result = cnpjService.validate(cnpj3);
      final cnpj4Result = cnpjService.validate(cnpj4);
      final cnpj5Result = cnpjService.validate(cnpj5);
      final cnpj6Result = cnpjService.validate(cnpj6);
      final cnpj7Result = cnpjService.validate(cnpj7);
      final cnpj8Result = cnpjService.validate(cnpj8);
      final cnpj9Result = cnpjService.validate(cnpj9);
      final cnpj0Result = cnpjService.validate(cnpj0);

      expect(cnpj1Result, equals('All characters are the same'));
      expect(cnpj2Result, equals('All characters are the same'));
      expect(cnpj3Result, equals('All characters are the same'));
      expect(cnpj4Result, equals('All characters are the same'));
      expect(cnpj5Result, equals('All characters are the same'));
      expect(cnpj6Result, equals('All characters are the same'));
      expect(cnpj7Result, equals('All characters are the same'));
      expect(cnpj8Result, equals('All characters are the same'));
      expect(cnpj9Result, equals('All characters are the same'));
      expect(cnpj0Result, equals('All characters are the same'));
    });

    test('validate: Invalid format', () {
      const cnpj1 = '092418650001A4';
      const cnpj2 = '6399165900017B';
      const cnpj3 = '036722360001XZ';

      final cnpj1Result = cnpjService.validate(cnpj1);
      final cnpj2Result = cnpjService.validate(cnpj2);
      final cnpj3Result = cnpjService.validate(cnpj3);

      expect(cnpj1Result, equals('Invalid format'));
      expect(cnpj2Result, equals('Invalid format'));
      expect(cnpj3Result, equals('Invalid format'));
    });

    test('validate: Verification digits are invalid', () {
      const cnpj1 = '47670496000175';
      const cnpj2 = '34485113000140';
      const cnpj3 = '84568602000100';
      const cnpj4 = '06038525000101';
      const cnpj5 = '45722993000199';

      final cnpj1Result = cnpjService.validate(cnpj1);
      final cnpj2Result = cnpjService.validate(cnpj2);
      final cnpj3Result = cnpjService.validate(cnpj3);
      final cnpj4Result = cnpjService.validate(cnpj4);
      final cnpj5Result = cnpjService.validate(cnpj5);

      expect(cnpj1Result, equals('Invalid verification digits'));
      expect(cnpj2Result, equals('Invalid verification digits'));
      expect(cnpj3Result, equals('Invalid verification digits'));
      expect(cnpj4Result, equals('Invalid verification digits'));
      expect(cnpj5Result, equals('Invalid verification digits'));
    });

    /// Checks if [CnpjService] can generate CNPJs that passes its onw
    /// validation.
    test('nextCNPJ: new standard passes in validate() function', () {
      for (var i = 0; i < 1000; i++) {
        final cnpj = cnpjService.nextCNPJ();
        expect(cnpjService.validate(cnpj), isNull);
      }
    });

    test('nextCNPJ: old standard passes in validate() function', () {
      for (var i = 0; i < 1000; i++) {
        final cnpj = cnpjService.nextCNPJ(StandardMode.old);
        expect(cnpjService.validate(cnpj), isNull);
      }
    });
  });
}
