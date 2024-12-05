import 'dart:math';

class RandomNumberGenerator {
  static final List<String> letters = List.generate(
    26,
    (index) => String.fromCharCode(index + 65),
  );

  static final List<String> numbers = List.generate(
    10,
    (index) => '$index',
  );

  static String nextAlphanumeric([int length = 1]) {
    final List<String> result = List.generate(
      length,
      (_) {
        final bool generateLetter = Random().nextInt(2).isEven;
        return generateLetter ? nextLetter() : nextNumber();
      },
    );

    return result.join();
  }

  static String nextLetter([int length = 1]) => List.generate(
        length,
        (_) => letters[Random().nextInt(letters.length)],
      ).join();

  static String nextNumber([int length = 1]) => List.generate(
        length,
        (index) => numbers[Random().nextInt(numbers.length)],
      ).join();
}
