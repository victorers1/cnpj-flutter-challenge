import 'package:cnpj_flutter_challenge/enums/input_mask.dart';
import 'package:cnpj_flutter_challenge/enums/validation_mode.dart';

/// This is the Model layer of the Home page
class HomeState {
  final String inputText;
  final InputMask inputMask;
  final ValidationMode validationMode;

  HomeState({
    this.inputText = '',
    InputMask? inputMask,
    ValidationMode? validationMode,
  })  : inputMask = inputMask ?? InputMask.defaultValue,
        validationMode = validationMode ?? ValidationMode.defaultValue;

  HomeState copyWith({
    String? inputText,
    InputMask? inputMask,
    ValidationMode? validationMode,
  }) {
    return HomeState(
      inputText: inputText ?? this.inputText,
      inputMask: inputMask ?? this.inputMask,
      validationMode: validationMode ?? this.validationMode,
    );
  }

  HomeState toggleInputMask() => copyWith(
        inputMask:
            inputMask == InputMask.apply ? InputMask.none : InputMask.apply,
      );

  HomeState toggleValidationMode() => copyWith(
        validationMode: validationMode == ValidationMode.always
            ? ValidationMode.atTheEnd
            : ValidationMode.always,
      );
}
