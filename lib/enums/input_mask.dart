enum InputMask {
  apply(
    description: '##.###.###/####-##',
    finalLength: 18,
  ),
  none(
    description: 'None',
    finalLength: 14,
  );

  const InputMask({
    required this.description,
    required this.finalLength,
  });

  final String description;
  final int finalLength;

  static InputMask get defaultValue => InputMask.apply;
}
