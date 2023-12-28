import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String labelText;
  final void Function() onPressed;

  const PrimaryButton(
      {super.key, required this.labelText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        labelText.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
