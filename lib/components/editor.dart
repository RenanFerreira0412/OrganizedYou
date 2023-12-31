import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:organized_you/theme/app_theme.dart';

class Editor extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int maxLength;
  final int maxLines;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final FormFieldValidator validator;
  final bool readOnly;
  final VoidCallback? action;

  const Editor(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.validator,
      required this.maxLength,
      required this.maxLines,
      required this.isPasswordField,
      required this.keyboardType,
      this.action,
      required this.readOnly});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  late bool _isPasswordField;
  late bool _seePassword;

  @override
  void initState() {
    super.initState();
    _isPasswordField = widget.isPasswordField;
    _seePassword = widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        obscureText: _seePassword,
        readOnly: widget.readOnly,
        onTap: widget.action,
        style: AppTheme.typo.regular(13, AppTheme.colors.white, 1, 1.5),
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          helperText: widget.hintText,
          suffixIcon: _isPasswordField
              ? (_seePassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          //Quando o usuário clicar nesse ícone, ele mudará para falso
                          debugPrint('Você está vendo a sua senha');
                          _seePassword = false;
                        });
                      },
                      icon: const LineIcon.eyeSlash(),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          //Quando o usuário clicar neste ícone, ele mudará para verdadeiro
                          debugPrint('Você não está vendo a sua senha');
                          _seePassword = true;
                        });
                      },
                      icon: const LineIcon.eye()))
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}
