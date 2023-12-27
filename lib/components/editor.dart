import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FormFieldValidator validator;

  const Editor(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: validator,
    );
  }
}
