extension StringExt on String {
  bool get allCharsAreEquals => split('').every(
        (char) => char == substring(0, 1),
      );

  /// Inserts a [char] at [index].
  /// If the position [index] is already occupied with a [char], use
  /// [dontDuplicate] to do nothing or add another occurence.
  String insertAt(int index, String char, {bool dontDuplicate = true}) {
    return dontDuplicate && getChatAtOrNull(index) == char
        ? this
        : '${substring(0, index)}$char${substring(index)}';
  }

  String? getChatAtOrNull(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    } else {
      return null;
    }
  }
}
