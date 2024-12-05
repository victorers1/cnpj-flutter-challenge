import 'package:cnpj_flutter_challenge/enums/input_mask.dart';
import 'package:cnpj_flutter_challenge/enums/validation_mode.dart';
import 'package:cnpj_flutter_challenge/text_formatters/cnpj_text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CnpjFormField extends StatelessWidget {
  const CnpjFormField({
    super.key,
    required this.controller,
    required this.inputMask,
    required this.validationMode,
    required this.validator,
    required this.removeMaskFunction,
  });

  final InputMask inputMask;
  final ValidationMode validationMode;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String Function(String cnpj) removeMaskFunction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(_inputMaxLength),
        if (inputMask == InputMask.apply)
          const TextInputFormatter.withFunction(formatEditUpdate)
      ],
      decoration: InputDecoration(
        hintText: 'CNPJ',
        border: const OutlineInputBorder(),
        counterText: _cnpjWithoutMaskLength.toString(),
      ),
      validator: getValidator(),
      autovalidateMode: AutovalidateMode.always,
    );
  }

  int get _cnpjWithoutMaskLength => removeMaskFunction(controller.text).length;

  int get _inputMaxLength => inputMask == InputMask.apply ? 18 : 14;

  /// Returns the [validator] function when:
  /// - User has configured [ValidationMode.always]
  /// - User has configured [ValidationMode.atTheEnd] and He has inserted all 14
  /// digits of the CNPJ
  String? Function(String?)? getValidator() {
    if (validationMode == ValidationMode.always) {
      return validator;
    } else if (_cnpjWithoutMaskLength == 14) {
      return validator;
    }
    return null;
  }
}
