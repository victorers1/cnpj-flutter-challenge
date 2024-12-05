import 'dart:math';

import 'package:cnpj_flutter_challenge/enums/standard_mode.dart';
import 'package:cnpj_flutter_challenge/extensions/string_extensions.dart';
import 'package:cnpj_flutter_challenge/services/random_number_generator.dart';
import 'package:cnpj_flutter_challenge/text_formatters/cnpj_text_formatter.dart';

class CnpjService {
  static final regexCNPJ = RegExp(r'^([A-Z\d]){12}(\d){2}$');
  static final regexMaskCharacters = RegExp(r'[./-]');
  static final regexInvalidCharacters = RegExp(
    r'[^A-Z\d./-]',
    caseSensitive: true,
  );
  static final regexValidDigits = RegExp(r'[A-Z\d]', caseSensitive: true);
  static final List<int> weightsDV = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  static const int cnpjLength = 14;
  static const int cnpjWithoutDVLength = 12;

  /// Generates the digits of a valid CNPJ
  String nextCNPJ([StandardMode standard = StandardMode.latest]) {
    String root;
    String order;
    if (standard == StandardMode.latest) {
      root = RandomNumberGenerator.nextAlphanumeric(8);
      order = RandomNumberGenerator.nextAlphanumeric(4);
    } else {
      root = RandomNumberGenerator.nextNumber(8);
      order = RandomNumberGenerator.nextNumber(4);
    }

    final firstDigits = root + order;
    return '$firstDigits${calcDV(firstDigits)}';
  }

  /// Validates if [cnpj] is valid.
  /// Returns:
  /// - String indicating the error
  /// - null if [cnpj] is valid
  String? validate(String? cnpj) {
    if (cnpj == null) return 'Field is mandatory';

    cnpj = removeMask(cnpj);

    if (regexInvalidCharacters.hasMatch(cnpj)) {
      return 'Input contains invalid characters';
    }

    if (cnpj.length > cnpjLength) {
      return 'Too many characters';
    } else if (cnpj.length < cnpjLength) {
      return 'Insufficient characters';
    }

    final cnpjDigits = cnpj.replaceAll(regexMaskCharacters, '');

    if (cnpjDigits.allCharsAreEquals) {
      return 'All characters are the same';
    }

    if (!regexCNPJ.hasMatch(cnpjDigits)) return 'Invalid format';

    final actualDV = cnpjDigits.substring(cnpjWithoutDVLength);
    final expectedDV = calcDV(cnpjDigits.substring(0, cnpjWithoutDVLength));

    if (actualDV != expectedDV) return 'Invalid verification digits';

    return null;
  }

  /// Returns the 2 last digits of the CNPJ, a.k.a. Verification Digits (DV)
  /// [cnpj] should be the 12 first digits of a valid CNPJ number
  String calcDV(String cnpj) {
    final firstDV = calcFirstDV(cnpj);
    final secondDV = calcSecondDV(cnpj + firstDV);
    return '$firstDV$secondDV';
  }

  /// Returns the first Verification Digit
  /// [cnpj] should be the 12 first digits of a valid CNPJ number
  String calcFirstDV(String cnpj) {
    final List<int> weights = weightsDV.skip(1).toList();
    final List<int> digits = cnpj.split('').map((d) => digitToInt(d)).toList();

    int sum = getAccumulatedMultiplication(weights, digits);

    final divRemainder = sum % 11;
    if (divRemainder <= 1) return '0';

    return (11 - divRemainder).toString();
  }

  /// Returns the second Verification Digit
  /// [cnpj] should be the 13 first digits of a valid CNPJ number
  String calcSecondDV(String cnpj) {
    final List<int> digits = cnpj.split('').map((d) => digitToInt(d)).toList();

    int sum = getAccumulatedMultiplication(weightsDV, digits);

    final divRemainder = sum % 11;
    if (divRemainder <= 1) return '0';

    return (11 - divRemainder).toString();
  }

  /// Receives 2 Lists<int> of exact same length.
  ///
  /// Execute these steps:
  /// - Calculates a third List<int> where each element is the multiplication of
  /// the elements at the same position of each passed List
  /// - Sums all the elements in the resulting list
  /// - Returns the sum of the previous step
  int getAccumulatedMultiplication(List<int> weights, List<int> digits) {
    final length = min(weights.length, digits.length);
    final List<(int, int)> pairs = List.generate(length, (index) {
      return (weights[index], digits[index]);
    });

    final sum = pairs.fold(
      0,
      (previousValue, currentPair) {
        final weight = currentPair.$1;
        final digit = currentPair.$2;
        return previousValue + (weight * digit);
      },
    );
    return sum;
  }

  /// [digit] is a letter or a number. Other types of characters will throw a
  /// RangeError.
  ///
  /// Returns the equivalent [int] used in the CNPJ calculation.
  ///
  /// Letters are equivalent to their ASCII Table values substracted by 48,
  /// thus:
  /// A=17, B=18, C=19, and so on.
  int digitToInt(String digit) {
    final baseValue = '0'.codeUnitAt(0);
    if (regexValidDigits.hasMatch(digit)) {
      return digit.toUpperCase().codeUnitAt(0) - baseValue;
    } else {
      throw RangeError('Digit is not Alpha numeric');
    }
  }
}
