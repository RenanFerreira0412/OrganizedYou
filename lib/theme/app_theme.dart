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
      colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.colors.offWhite),
      useMaterial3: false,
      fontFamily: "Satoshi",
      scaffoldBackgroundColor: AppTheme.colors.dark,
      dividerColor: AppTheme.colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: AppTheme.colors.dark,
        actionsIconTheme: IconThemeData(color: AppTheme.colors.white),
        titleTextStyle:
            AppTheme.typo.medium(20, AppTheme.colors.white, 1.5, 1.5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: colors.greyText,
        floatingLabelStyle:
            AppTheme.typo.regular(13, AppTheme.colors.white, 1, 1.5),
        labelStyle: AppTheme.typo.regular(13, AppTheme.colors.white, 1, 1.5),
        hintStyle: AppTheme.typo.medium(13, Colors.white54, 1.5, 1.5),
        helperStyle: AppTheme.typo.medium(13, Colors.white54, 1.5, 1.5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        errorStyle: AppTheme.typo.regular(13, AppTheme.colors.red, 1, 1.5),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.white, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.red, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.blue, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.red, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
