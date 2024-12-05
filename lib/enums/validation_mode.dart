enum ValidationMode {
  always(description: 'On each insert'),
  atTheEnd(description: 'Only at the end');

  const ValidationMode({required this.description});

  final String description;

  static ValidationMode get defaultValue => ValidationMode.atTheEnd;
}
