import 'package:cnpj_flutter_challenge/enums/input_mask.dart';
import 'package:cnpj_flutter_challenge/enums/standard_mode.dart';
import 'package:cnpj_flutter_challenge/enums/validation_mode.dart';
import 'package:cnpj_flutter_challenge/pages/home_store.dart';
import 'package:cnpj_flutter_challenge/pages/widgets/cnpj_input.dart';
import 'package:cnpj_flutter_challenge/text_formatters/cnpj_text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This is the View layer of the Home
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final store = context.watch<HomeStore>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CNPJ Validator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: store.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CnpjFormField(
                inputMask: store.inputMask,
                validator: store.validateCNPJ,
                controller: store.cnpjController,
                validationMode: store.validationMode,
                removeMaskFunction: removeMask,
              ),
              const SizedBox(height: 32),
              Text(
                'Options',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SwitchListTile.adaptive(
                title: const Text('Mask'),
                subtitle: Text(store.inputMask.description),
                value: store.inputMask == InputMask.defaultValue,
                onChanged: (value) => store.toggleInputMask(),
              ),
              SwitchListTile.adaptive(
                title: const Text('Validation mode'),
                subtitle: Text(store.validationMode.description),
                value: store.validationMode == ValidationMode.defaultValue,
                onChanged: (value) => store.toggleValidationMode(),
              ),
              const SizedBox(height: 32),
              Text(
                'Generate',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => store.generateCNPJ(StandardMode.old),
                child: const Text('Old standard'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => store.generateCNPJ(StandardMode.latest),
                child: const Text('New standard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
