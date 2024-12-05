import 'package:cnpj_flutter_challenge/extensions/string_extensions.dart';
import 'package:flutter/widgets.dart';

TextEditingValue formatEditUpdate(
  TextEditingValue oldValue,
  TextEditingValue newValue,
) {
  String newCnpj = newValue.text;
  String oldCnpj = oldValue.text;

  final userIsInserting = newCnpj.length >= oldCnpj.length;
  if (userIsInserting) {
    if (newCnpj.length >= 3) {
      newCnpj = newCnpj.insertAt(2, '.');
    }

    if (newCnpj.length >= 7) {
      newCnpj = newCnpj.insertAt(6, '.');
    }

    if (newCnpj.length >= 11) {
      newCnpj = newCnpj.insertAt(10, '/');
    }

    if (newCnpj.length >= 16) {
      newCnpj = newCnpj.insertAt(15, '-');
    }
  } else {
    final endsWithDot = newCnpj.endsWith('.');
    final endsWithSlash = newCnpj.endsWith('/');
    final endsWithHyphen = newCnpj.endsWith('-');
    if (endsWithDot || endsWithSlash || endsWithHyphen) {
      newCnpj = newCnpj.substring(0, newCnpj.length - 1);
    }
  }

  return TextEditingValue(text: newCnpj);
}

String applyMask(String cnpj) => formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: cnpj),
    ).text;

String removeMask(String cnpj) =>
    cnpj.replaceAll('.', '').replaceAll('/', '').replaceAll('-', '');
