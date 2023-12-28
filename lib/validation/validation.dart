import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class FormValidation {
  static String errorMsg = 'Campo Obrigatório!';

  static FormFieldValidator validateEmail() => (value) {
        if (value == null || value.isEmpty) {
          return errorMsg;
        }

        if (!EmailValidator.validate(value, true)) {
          return 'Informe um e-mail válido';
        }

        return null;
      };

  static FormFieldValidator validateConfirmPassword(String passwordText) =>
      (value) {
        if (value == null || value.isEmpty) {
          return errorMsg;
        }

        if (value != passwordText) {
          return 'Informe a mesma senha.';
        }

        return null;
      };

  static FormFieldValidator validateField() => (value) {
        if (value == null || value.isEmpty) {
          return errorMsg;
        }
        return null;
      };
}
