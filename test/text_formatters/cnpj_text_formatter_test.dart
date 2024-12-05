import 'package:cnpj_flutter_challenge/text_formatters/cnpj_text_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CNPJ Text Formatter', () {
    test('formatEditUpdate', () {
      const cnpj1Before = TextEditingValue(text: 'HZ.OW1.V10/Q0D3');
      const cnpj1After = TextEditingValue(text: 'HZ.OW1.V10/Q0D32');

      const cnpj2Before = TextEditingValue(text: 'I6');
      const cnpj2After = TextEditingValue(text: 'I65');

      const cnpj3Before = TextEditingValue(text: '00.472');
      const cnpj3After = TextEditingValue(text: '00.4725');

      const cnpj4Before = TextEditingValue(text: 'HU.F8H.8VV/G');
      const cnpj4After = TextEditingValue(text: 'HU.F8H.8VV/');

      final cnpj1Result = formatEditUpdate(cnpj1Before, cnpj1After);
      final cnpj2Result = formatEditUpdate(cnpj2Before, cnpj2After);
      final cnpj3Result = formatEditUpdate(cnpj3Before, cnpj3After);
      final cnpj4Result = formatEditUpdate(cnpj4Before, cnpj4After);

      expect(cnpj1Result.text, equals('HZ.OW1.V10/Q0D3-2'));
      expect(cnpj2Result.text, equals('I6.5'));
      expect(cnpj3Result.text, equals('00.472.5'));
      expect(cnpj4Result.text, equals('HU.F8H.8VV'));
    });

    test('applyMask', () {
      const cnpj1 = 'HZOW1V10Q0D3';
      const cnpj2 = 'I6';
      const cnpj3 = '00472';
      const cnpj4 = 'HUF8H8VV';
      const cnpj1After = 'HZOW1V10Q0D32';
      const cnpj2After = 'I65';
      const cnpj3After = '004725';
      const cnpj4After = 'HUF8H8VVG';

      final cnpj1Result = applyMask(cnpj1);
      final cnpj2Result = applyMask(cnpj2);
      final cnpj3Result = applyMask(cnpj3);
      final cnpj4Result = applyMask(cnpj4);
      final cnpj1AfterResult = applyMask(cnpj1After);
      final cnpj2AfterResult = applyMask(cnpj2After);
      final cnpj3AfterResult = applyMask(cnpj3After);
      final cnpj4AfterResult = applyMask(cnpj4After);

      expect(cnpj1Result, equals('HZ.OW1.V10/Q0D3'));
      expect(cnpj2Result, equals('I6'));
      expect(cnpj3Result, equals('00.472'));
      expect(cnpj4Result, equals('HU.F8H.8VV'));
      expect(cnpj1AfterResult, equals('HZ.OW1.V10/Q0D3-2'));
      expect(cnpj2AfterResult, equals('I6.5'));
      expect(cnpj3AfterResult, equals('00.472.5'));
      expect(cnpj4AfterResult, equals('HU.F8H.8VV/G'));
    });

    test('removeMask', () {
      const cnpj1 = 'HZ.OW1.V10/Q0D3';
      const cnpj2 = 'I6';
      const cnpj3 = '00.472';
      const cnpj4 = 'HU.F8H.8VV';
      const cnpj1After = 'HZ.OW1.V10/Q0D3-2';
      const cnpj2After = 'I6.5';
      const cnpj3After = '00.472.5';
      const cnpj4After = 'HU.F8H.8VV/G';

      final cnpj1Result = removeMask(cnpj1);
      final cnpj2Result = removeMask(cnpj2);
      final cnpj3Result = removeMask(cnpj3);
      final cnpj4Result = removeMask(cnpj4);
      final cnpj1AfterResult = removeMask(cnpj1After);
      final cnpj2AfterResult = removeMask(cnpj2After);
      final cnpj3AfterResult = removeMask(cnpj3After);
      final cnpj4AfterResult = removeMask(cnpj4After);

      expect(cnpj1Result, equals('HZOW1V10Q0D3'));
      expect(cnpj2Result, equals('I6'));
      expect(cnpj3Result, equals('00472'));
      expect(cnpj4Result, equals('HUF8H8VV'));
      expect(cnpj1AfterResult, equals('HZOW1V10Q0D32'));
      expect(cnpj2AfterResult, equals('I65'));
      expect(cnpj3AfterResult, equals('004725'));
      expect(cnpj4AfterResult, equals('HUF8H8VVG'));
    });
  });
}
