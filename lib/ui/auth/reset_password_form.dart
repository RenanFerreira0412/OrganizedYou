import 'package:flutter/material.dart';
import 'package:organized_you/components/editor.dart';
import 'package:organized_you/validation/validation.dart';

class ResetPasswordForm extends StatelessWidget {
  final TextEditingController email;
  final GlobalKey<FormState> formKey;

  const ResetPasswordForm(
      {super.key, required this.email, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Editor(
              controller: email,
              labelText: 'E-mail',
              hintText: 'Informe o seu e-mail',
              validator: FormValidation.validateEmail(),
              maxLength: 50,
              maxLines: 1,
              isPasswordField: false,
              keyboardType: TextInputType.emailAddress),
        ],
      ),
    );
  }
}
