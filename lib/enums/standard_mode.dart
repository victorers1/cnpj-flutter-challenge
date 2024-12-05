enum StandardMode {
  old(description: 'Old (pre 2026)'),
  latest(description: 'New (starting 2026)');

  const StandardMode({required this.description});

  final String description;

  static StandardMode get defaultValue => StandardMode.latest;
}
