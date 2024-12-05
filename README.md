# CNPJ Flutter Challenge

The Federal Revenue Service published the *Normative Instruction RFB No. 2,229, of October 15, 2024*, which changes the format of the National Registry of Legal Entities (CNPJ). In response to the growing demand for new CNPJ numbers, the format will be modified to include letters and numbers.

The transition to the alphanumeric format will be progressive and is scheduled for July 2026.

The new CNPJ identification number will have 14 positions. The first eight will identify the root of the new number, composed of letters and numbers. The following four will represent the order of the establishment, also alphanumeric. The last two positions, which correspond to the verification digits, will continue to be numeric.

It is important to note that this change will not affect existing CNPJs. The current numbers will remain valid, and the verification digits will also not be changed.

Although the routine for calculating the verification digit (DV) has been adjusted, the formula for calculating it using modulo 11 will continue to be used. The main difference will be the replacement of the numeric and alphanumeric values ​​by the decimal value corresponding to the code in the ASCII table, subtracting the value 48 from it. Thus, the values ​​will be, for example, A=17, B=18, C=19, and so on.

The implementation of the alphanumeric CNPJ aims to guarantee the continuity of public policies and ensure the availability of identification numbers, without causing significant technical impacts to Brazilian society.

## Environment

```text
> flutter doctor
[✓] Flutter (Channel stable, 3.24.0, on macOS 14.6.1 23G93 darwin-arm64, locale en-BR)
[✓] Android toolchain - develop for Android devices (Android SDK version 35.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 15.4)
[✓] Android Studio (version 2024.2)
[✓] VS Code (version 1.95.3)
```

```text
> About This Mac
MacBook Pro
16-Inch, 2021
Chip Apple M1 Pro
Memory 16 GB
macOS 14.6.1 (23G93)
```

## Tests

To run all tests with coverage information, execute `flutter test --coverage`. This will re-generate the `coverage` folder on project's root location with the `lcov.info`. You can use that file together with a program to generate a visual representation of the coverage.

In this project, it was already done using the [macOS implementation of lcov](https://formulae.brew.sh/formula/lcov) and the command `genhtml coverage/lcov.info -o coverage/html`. The result is in `coverage/html`. Open the `index.html` on your browser to see it.

## Links

- [Old algorithm](https://www.geradorcnpj.com/algoritmo_do_cnpj.htm)
- [Old algorithm implementation](https://www.geradorcnpj.com/javascript-validar-cnpj.htm)
- [News about the new format](https://www.gov.br/receitafederal/pt-br/assuntos/noticias/2024/outubro/cnpj-tera-letras-e-numeros-a-partir-de-julho-de-2026)
