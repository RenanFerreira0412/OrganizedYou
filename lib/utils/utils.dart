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
}
