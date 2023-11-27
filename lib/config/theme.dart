import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import 'constants.dart';

class AppThemeData {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: MaterialColorGenerator.from(AppColors.primaryColor),
    primaryColorDark: MaterialColorGenerator.from(AppColors.primaryColor),
    primaryColor: MaterialColorGenerator.from(AppColors.primaryColor),
    appBarTheme: const AppBarTheme(color: Colors.black),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (states) => AppColors.primaryColor,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Colors.white,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColorDark: MaterialColorGenerator.from(AppColors.primaryColor),
    primaryColor: MaterialColorGenerator.from(AppColors.primaryColor),
    primarySwatch: MaterialColorGenerator.from(AppColors.primaryColor),
    appBarTheme: const AppBarTheme(color: Colors.white),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (states) => AppColors.primaryColor,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.black),
    ),
  );
}
