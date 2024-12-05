import 'package:cnpj_flutter_challenge/enums/input_mask.dart';
import 'package:cnpj_flutter_challenge/enums/standard_mode.dart';
import 'package:cnpj_flutter_challenge/enums/validation_mode.dart';
import 'package:cnpj_flutter_challenge/pages/home_state.dart';
import 'package:cnpj_flutter_challenge/services/cnpj_service.dart';
import 'package:cnpj_flutter_challenge/text_formatters/cnpj_text_formatter.dart';
import 'package:flutter/material.dart';

/// This is the ViewModel layer of the Home page
class HomeStore extends ValueNotifier<HomeState> {
  final CnpjService _cnpjService;
  final cnpjController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  HomeStore(this._cnpjService) : super(HomeState()) {
    cnpjController.addListener(
      () {
        value = value.copyWith(inputText: cnpjController.text);

        if (cnpjCurrentLength == 14 &&
            !(validationMode == ValidationMode.always)) {
          formKey.currentState?.validate();
        }
      },
    );
  }

  ValidationMode get validationMode => value.validationMode;
  InputMask get inputMask => value.inputMask;
  String get cnpj => value.inputText;
  int get cnpjCurrentLength => removeMask(value.inputText).length;

  String? validateCNPJ(String? cnpj) => _cnpjService.validate(
        removeMask(cnpj ?? ''),
      );

  void generateCNPJ(StandardMode standard) {
    final nextCNPJ = _cnpjService.nextCNPJ(standard);
    cnpjController.text =
        (inputMask == InputMask.apply) ? applyMask(nextCNPJ) : nextCNPJ;
  }

  void toggleInputMask() {
    value = value.toggleInputMask();

    if (value.inputMask == InputMask.apply) {
      cnpjController.text = applyMask(cnpj);
    } else {
      cnpjController.text = removeMask(cnpjController.text);
    }
  }

  void toggleValidationMode() {
    formKey.currentState?.reset();
    value = value.toggleValidationMode();
  }
}
