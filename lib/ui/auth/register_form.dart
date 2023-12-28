import 'package:flutter/material.dart';
import 'package:organized_you/components/editor.dart';
import 'package:organized_you/validation/validation.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final GlobalKey<FormState> formKey;

  const RegisterForm(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.formKey});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String passwordVal = "";

  @override
  void initState() {
    super.initState();
    if (mounted) {
      updatePasswordVal();
    }
  }

  void updatePasswordVal() {
    widget.password.addListener(_passwordListener);
  }

  void _passwordListener() {
    setState(() {
      passwordVal = widget.password.text;
    });
  }

  @override
  void dispose() {
    widget.password.removeListener(_passwordListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            Editor(
                controller: widget.name,
                labelText: 'Nome',
                hintText: 'Informe o seu nome',
                validator: FormValidation.validateField(),
                maxLength: 100,
                maxLines: 1,
                isPasswordField: false,
                keyboardType: TextInputType.name),
            Editor(
                controller: widget.email,
                labelText: 'E-mail',
                hintText: 'Informe o seu e-mail',
                validator: FormValidation.validateEmail(),
                maxLength: 50,
                maxLines: 1,
                isPasswordField: false,
                keyboardType: TextInputType.emailAddress),
            Editor(
                controller: widget.password,
                labelText: 'Senha',
                hintText: 'Informe a sua senha',
                validator: FormValidation.validateField(),
                maxLength: 50,
                maxLines: 1,
                isPasswordField: true,
                keyboardType: TextInputType.visiblePassword),
            Editor(
                controller: widget.confirmPassword,
                labelText: 'Confirmar Senha',
                hintText: 'Repita a senha informada',
                validator: FormValidation.validateConfirmPassword(passwordVal),
                maxLength: 50,
                maxLines: 1,
                isPasswordField: true,
                keyboardType: TextInputType.visiblePassword)
          ],
        ));
  }
}
