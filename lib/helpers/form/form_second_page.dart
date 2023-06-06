import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart ';
import 'form_data.dart';

class SecondFormPage extends StatelessWidget {
  const SecondFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<FormData>(context);
    final _formKey2 = GlobalKey<FormBuilderState>();
    int ageYears = 0;
    final List<String> genderOptions = ['Feminino', 'Masculino', 'Outros'];
    final List<String> docOptions = ['RG', 'CPF', 'CNPJ'];
    final _cpfCnpjFormatter =
        TextInputMask(mask: ['999.999.999-99', '999.999.999/9999-9']);
    final _rgFormatter = TextInputMask(mask: [
      '99.999.999-99',
      '9.999.999-99',
      'AA-99.999.999',
      '999.999.999'
    ]);

    String? selectedDocumentType = 'CPF';
    List<TextInputFormatter>? _getDocumentNumberFormatter() {
      switch (selectedDocumentType) {
        case 'CPF':
          return [_cpfCnpjFormatter];
        case 'CNPJ':
          return [_cpfCnpjFormatter];
        case 'RG':
          return [_rgFormatter];
        default:
          return null;
      }
    }

    Future<int> idade(DateTime a) async {
      DateTime c = DateTime.now();
      Duration difference = c.difference(a);
      int d = difference.inDays;
      ageYears = (d / 365).floor();
      return ageYears;
    }

    // return ChangeNotifierProvider<FormData>(
    //   create: (_) => FormData(),
    //   child: Scaffold(
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<FormData>(
          builder: (context, formData, child) => FormBuilder(
            key: _formKey2,
            initialValue: formData.toFirestore(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FormBuilderDropdown<String>(
                  name: 'documentType',
                  decoration: const InputDecoration(
                      labelText: 'Documento de Identidade'),
                  initialValue: 'CPF',
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  items: docOptions
                      .map((doctype) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: doctype,
                            child: Text(doctype),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      selectedDocumentType = val;
                      formData.documentType = val;
                    }
                  },
                  valueTransformer: (val) => val?.toString(),
                ),
                const SizedBox(height: 8),
                FormBuilderTextField(
                    name: 'documentNumber',
                    inputFormatters: _getDocumentNumberFormatter(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Número do Documento',
                        border: OutlineInputBorder()),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.max(13)
                    ]),
                    onChanged: (val) {
                      formData.documentNumber = val!;
                    }),
                const SizedBox(height: 8),
                FormBuilderDateTimePicker(
                  name: 'birthDate',
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  initialValue: DateTime.now(),
                  inputType: InputType.date,
                  decoration: const InputDecoration(
                    labelText: 'Data de Nascimento',
                  ),
                  onChanged: (val) {
                    formData.birthDate = val! as Timestamp?;
                    idade(formData.birthDate! as DateTime);
                  },
                ),
                const SizedBox(height: 16),
                FormBuilderDropdown<String>(
                  name: 'gender',
                  decoration: const InputDecoration(
                    labelText: 'Gênero',
                  ),
                  initialValue: 'Feminino', //adicionar valor
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  items: genderOptions
                      .map((gender) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (val) {
                    formData.gender = val!;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Anterior'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey2.currentState!.saveAndValidate()) {
                          formData.id = FirebaseAuth.instance.currentUser?.uid;
                          formData.updateId(formData.id!);
                          formData.updateGender(formData.gender ?? 'Feminino');
                          formData.updateBirthDate(formData.birthDate!);
                          formData.updateAge(ageYears);
                          formData.updateDocumentType(
                              formData.documentType ?? 'CPF');
                          formData
                              .updateDocumentNumber(formData.documentNumber!);
                          if (kDebugMode) {
                            print(formData.toString());
                          }
                          //formData.update(_formKey2.currentState!.value);
                          Navigator.pushNamed(context, '/third',
                              arguments: formData);
                        }
                      },
                      child: const Text('Próximo'),
                    ),
                  ],
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
