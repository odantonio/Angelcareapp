import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart ';
import 'form_data.dart';

class ThirdFormPage extends StatelessWidget {
  const ThirdFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey3 = GlobalKey<FormBuilderState>();
    final formData = Provider.of<FormData>(context);
    final _cepFormatter = TextInputMask(mask: ['99.999-999']);

    final List<String> stateOptions = [
      'AC',
      'AL',
      'AM',
      'AP',
      'BA',
      'CE',
      'DF',
      'ES',
      'GO',
      'MA',
      'MG',
      'MS',
      'MT',
      'PA',
      'PB',
      'PE',
      'PI',
      'PR',
      'RJ',
      'RN',
      'RO',
      'RR',
      'RS',
      'SC',
      'SE',
      'SP',
      'TO'
    ];
    void submit() async {
      FirebaseFirestore db = FirebaseFirestore.instance;
      //final data = formData.toFirestore;
      final ref = db.collection("users").doc().withConverter(
            fromFirestore: FormData.fromFirestore,
            toFirestore: (FormData formData, _) => formData.toFirestore(),
          );
      await ref.set(formData);
    }

    // return ChangeNotifierProvider<FormData>(
    //   create: (_) => FormData(),
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<FormData>(
          builder: (context, formData, child) => FormBuilder(
            key: _formKey3,
            initialValue: formData.toFirestore(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FormBuilderTextField(
                  name: 'country',
                  decoration: const InputDecoration(
                    labelText: 'País',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: 'Brasil',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.min(6),
                  ]),
                  onChanged: (val) {
                    formData.country = val!;
                  },
                ),
                const SizedBox(height: 8),
                FormBuilderDropdown<String>(
                  name: 'state',
                  decoration: const InputDecoration(
                    labelText: 'Estado',
                  ),
                  initialValue: 'AC', // Defina o valor inicial aqui
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  items: stateOptions
                      .map((state) => DropdownMenuItem(
                            value: state,
                            child: Text(state),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      formData.state = val;
                    }
                  },
                  valueTransformer: (val) => val.toString(),
                ),
                const SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'city',
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.min(6),
                  ]),
                  onChanged: (val) {
                    formData.city = val!;
                  },
                ),
                const SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'cep',
                  inputFormatters: [_cepFormatter],
                  decoration: const InputDecoration(
                    labelText: 'CEP',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(8),
                  ]),
                  onChanged: (val) {
                    formData.cep = val!;
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
                        if (_formKey3.currentState!.saveAndValidate()) {
                          //formData.update(_formKey3.currentState!.value);
                          formData.updateCountry(formData.country ?? 'Brasil');
                          formData.updateState(formData.state ?? 'AC');
                          formData.updateCity(formData.city!);
                          formData.updateCep(formData.cep!);
                          submit();
                          if (kDebugMode) {
                            print(formData.toString());
                          }
                          Navigator.pushNamed(context, '/home');
                        }
                      },
                      child: const Text('Enviar'),
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

// class FormModel with ChangeNotifier {
//   String _mainAddress;
//   String _complAddress;
//   String _country;
//   String _state;
//   String _city;
//   String _cep;
//
//   String get mainAddress => _mainAddress;
//   String get complAddress => _complAddress;
//   String get country => _country;
//   String get state => _state;
//   String get city => _city;
//   String get cep => _cep;
//
//   set mainAddress(String value) {
//     _mainAddress = value;
//     notifyListeners();
//   }
//
//   set complAddress(String value) {
//     _complAddress = value;
//     notifyListeners();
//   }
//
//   set country(String value) {
//     _country = value;
//     notifyListeners();
//   }
//
//   set state(String value) {
//     _state = value;
//     notifyListeners();
//   }
//
//   set city(String value) {
//     _city = value;
//     notifyListeners();
//   }
//
//   set cep(String value) {
//     _cep = value;
//     notifyListeners();
//   }
//
//   void update(Map<String, dynamic> formData) {
//     mainAddress = formData['mainAddress'] ?? '';
//     complAddress = formData['complAddress'] ?? '';
//     country = formData['country'] ?? '';
//     state = formData['state'] ?? '';
//     city = formData['city'] ?? '';
//     cep = formData['cep'] ?? '';
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'mainAddress': _mainAddress,
//       'complAddress': _complAddress,
//       'country': _country,
//       'state': _state,
//       'city': _city,
//       'cep': _cep,
//     };
//   }
// }
