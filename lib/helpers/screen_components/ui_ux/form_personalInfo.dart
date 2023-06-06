import 'package:flutter/material.dart';

import '../../form/validations.dart';

class PersonalInfoForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController concilNumberControlle;
  final void Function() clearServerError;
  final bool serverError;
  final Map<String, dynamic> formData;

  const PersonalInfoForm({
    Key? key,
    required this.nameController,
    required this.cpfController,
    required this.emailController,
    required this.concilNumberControlle,
    required this.clearServerError,
    required this.serverError,
    required this.formData,
  }) : super(key: key);

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.nameController,
          validator: (text) => validateRequired(text, widget.serverError),
          // onTap: () => widget.clearServerError(),
          keyboardType: TextInputType.name,
          autovalidateMode: widget.serverError
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            label: Text('Nome*'),
          ),
          onSaved: (name) => {widget.formData['name'] = name ?? ''},
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: widget.cpfController,
          validator: (text) => validateCpf(text, widget.serverError),
          // onTap: () => widget.clearServerError(),
          keyboardType: TextInputType.number,
          autovalidateMode: widget.serverError
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            label: Text('CPF*'),
          ),
          onSaved: (cpf) => {widget.formData['cpf'] = int.parse(cpf!)},
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: widget.emailController,
          validator: (text) => validateEmail(
            text,
            widget.serverError,
          ), // onTap: () => widget.clearServerError(),
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: widget.serverError
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            label: Text('E-mail*'),
          ),
          onSaved: (email) => {widget.formData['email'] = email ?? ''},
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: widget.concilNumberControlle,
          validator: ((text) => validateRequired(text, widget.serverError)),
          // onTap: () => widget.clearServerError(),
          keyboardType: TextInputType.number,
          autovalidateMode: widget.serverError
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            label: Text('Nº do conselho*'),
          ),
          onSaved: (concil) =>
              {widget.formData['concilNumber'] = int.parse(concil!)},
        ),
      ],
    );
  }
}
