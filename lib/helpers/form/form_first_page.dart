import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'form_data.dart';

class FirstFormPage extends StatelessWidget {
  const FirstFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey1 = GlobalKey<FormBuilderState>();
    final _telFormatter = TextInputMask(mask: ['(99)99999-9999']);

    final List<String> typeOptions = ['Administrador', 'Monitorado'];

    final formData = Provider.of<FormData>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vamos Finalizar o Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<FormData>(
          builder: (context, formData, child) => FormBuilder(
            key: _formKey1,
            initialValue: formData.toFirestore(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FormBuilderDropdown<String>(
                  name: 'type',
                  decoration: const InputDecoration(
                    labelText: 'Tipo de Usuário',
                  ),
                  initialValue: 'Administrador', // Defina o valor inicial aqui
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  items: typeOptions
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      formData.type = val;
                    }
                  },
                  valueTransformer: (val) => val.toString(),
                ),
                const SizedBox(height: 8),
                FormBuilderTextField(
                    name: 'name',
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.max(50),
                    ]),
                    onChanged: (val) {
                      formData.fullName = val!;
                    }),
                const SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'phone',
                  inputFormatters: [_telFormatter],
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    hintText: 'DDD e nº do Telefone',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(11)
                  ]),
                  onChanged: (val) {
                    formData.phoneNumber = val!;
                  },
                ),
                const SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'mainAddress',
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(80),
                  ]),
                  onChanged: (val) {
                    formData.mainAddress = val!;
                  },
                ),
                const SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'complAddress',
                  decoration: const InputDecoration(
                    labelText: 'Complemento',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.max(80),
                  ]),
                  onChanged: (val) {
                    formData.complAddress = val;
                  },
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey1.currentState!.saveAndValidate()) {
                      formData.updateName(formData.fullName!);
                      formData.updateType(formData.type ?? 'Administrador');
                      formData.updatePhoneNumber(formData.phoneNumber!);
                      formData.updateMainAddress(formData.mainAddress!);
                      formData.updateComplAddress(formData.complAddress ?? '');
                      if (kDebugMode) {
                        print(formData.toString());
                      }
                      //formData.updateImage(image!);
                      //formData.update(_formKey1.currentState!.value);
                      Navigator.pushNamed(context, '/second');
                    }
                  },
                  child: const Text('Próximo'),
                ),
              ],
            ),
          ),
        ),
      ),
      //),
    );
  }
}
