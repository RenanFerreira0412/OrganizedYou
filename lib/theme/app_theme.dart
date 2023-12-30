import 'package:flutter/material.dart';
import 'package:organized_you/theme/colors.dart';
import 'package:organized_you/theme/typo.dart';

@immutable
class AppTheme {
  static const colors = AppColors();
  static const typo = AppTypo();

  const AppTheme._();

  static ThemeData define() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      fontFamily: "Satoshi",
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: colors.greyText,
      ),
    );
  }
}
