import 'package:flutter/material.dart';
import 'package:organized_you/components/editor.dart';
import 'package:organized_you/validation/validation.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController email;
  final TextEditingController password;
  final GlobalKey<FormState> formKey;

  const LoginForm(
      {super.key,
      required this.email,
      required this.password,
      required this.formKey});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Editor(
              controller: widget.email,
              labelText: 'E-mail',
              hintText: 'Informe o seu e-mail',
              validator: FormValidation.validateEmail(),
              maxLength: 50,
              maxLines: 1,
              isPasswordField: false,
              readOnly: false,
              keyboardType: TextInputType.emailAddress),
          Editor(
              controller: widget.password,
              labelText: 'Senha',
              hintText: 'Informe a sua senha',
              validator: FormValidation.validateField(),
              maxLength: 50,
              maxLines: 1,
              isPasswordField: true,
              readOnly: false,
              keyboardType: TextInputType.visiblePassword)
        ],
      ),
    );
  }
}
