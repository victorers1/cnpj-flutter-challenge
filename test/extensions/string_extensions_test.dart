import 'package:cnpj_flutter_challenge/extensions/string_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExt', () {
    test(
      'allCharsAreEquals',
      () {
        const one = '11111111111111';
        const two = '22222222222222';
        const three = '33333333333333';
        const four = '44444444444444';
        const five = '55555555555555';
        const six = '66666666666666';
        const seven = '77777777777777';
        const eight = '88888888888888';
        const nine = '99999999999999';
        const zero = '00000000000000';

        final oneResult = one.allCharsAreEquals;
        final twoResult = two.allCharsAreEquals;
        final threeResult = three.allCharsAreEquals;
        final fourResult = four.allCharsAreEquals;
        final fiveResult = five.allCharsAreEquals;
        final sixResult = six.allCharsAreEquals;
        final sevenResult = seven.allCharsAreEquals;
        final eightResult = eight.allCharsAreEquals;
        final nineResult = nine.allCharsAreEquals;
        final zeroResult = zero.allCharsAreEquals;

        expect(oneResult, isTrue);
        expect(twoResult, isTrue);
        expect(threeResult, isTrue);
        expect(fourResult, isTrue);
        expect(fiveResult, isTrue);
        expect(sixResult, isTrue);
        expect(sevenResult, isTrue);
        expect(eightResult, isTrue);
        expect(nineResult, isTrue);
        expect(zeroResult, isTrue);
      },
    );

    test('insertAt', () {
      const empty = '';
      const char = 'b';
      const word = 'word';

      final insertAtEmpty = empty.insertAt(0, 'a');
      final insertBeforeChar = char.insertAt(0, 'a');
      final insertSameChar = char.insertAt(0, 'b');
      final insertDuplicatedChar = char.insertAt(0, 'b', dontDuplicate: false);
      final insertAfterChar = char.insertAt(1, 'c');
      final insertBeforeWord = word.insertAt(0, 'a');
      final insertMiddleWord = word.insertAt(2, 'a');
      final insertAfterWord = word.insertAt(4, 'a');

      expect(() => empty.insertAt(2, 'a'), throwsA(isA<RangeError>()));
      expect(() => char.insertAt(2, 'a'), throwsA(isA<RangeError>()));
      expect(() => word.insertAt(5, 'a'), throwsA(isA<RangeError>()));

      expect(insertAtEmpty, equals('a'));
      expect(insertBeforeChar, equals('ab'));
      expect(insertSameChar, equals('b'));
      expect(insertDuplicatedChar, equals('bb'));
      expect(insertAfterChar, equals('bc'));
      expect(insertBeforeWord, equals('aword'));
      expect(insertMiddleWord, equals('woard'));
      expect(insertAfterWord, equals('worda'));
    });

    test('getChatAtOrNull', () {
      const empty = '';
      const char = 'b';
      const word = 'word';

      final emptyResult = empty.getChatAtOrNull(0);
      final charResult1 = char.getChatAtOrNull(0);
      final charResult2 = char.getChatAtOrNull(1);
      final wordResult1 = word.getChatAtOrNull(3);
      final wordResult2 = word.getChatAtOrNull(5);

      expect(emptyResult, isNull);
      expect(charResult1, equals('b'));
      expect(charResult2, isNull);
      expect(wordResult1, equals('d'));
      expect(wordResult2, isNull);
    });
  });
}
