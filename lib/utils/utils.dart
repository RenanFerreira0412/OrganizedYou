import 'package:flutter/material.dart';

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

  static Color? chipColor(String category) {
    var data = {
      "Acadêmico": const Color(0xffEF5350),
      "Pessoal": const Color(0xff7E57C2),
      "Trabalho": const Color(0xff66BB6A)
    };

    return data[category];
  }
}
