import 'package:flutter/material.dart';
import 'package:organized_you/models/card_color.dart';
import 'package:organized_you/theme/app_theme.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static schowSnackBar(String text) {
    if (text == '') return;

    final snackBar = SnackBar(content: Text(text));

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Widget addVerticalSpace(double value) {
    return SizedBox(
      height: value,
    );
  }

  static Widget addHorizontalSpace(double value) {
    return SizedBox(
      width: value,
    );
  }

  static Widget addSpace() {
    return const Spacer();
  }

  static String toCapitalization(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String strDigits(int n) => n.toString().padLeft(2, '0');

  static List<String> categories = ["Acadêmico", "Pessoal", "Trabalho"];

  static CardColor? cardColor(String category) {
    var data = {
      "Acadêmico": CardColor(
          primary: AppTheme.colors.red, secondary: AppTheme.colors.redDark),
      "Pessoal": CardColor(
          primary: AppTheme.colors.purple,
          secondary: AppTheme.colors.purpleDark),
      "Trabalho": CardColor(
          primary: AppTheme.colors.green, secondary: AppTheme.colors.greenDark)
    };

    return data[category];
  }
}
