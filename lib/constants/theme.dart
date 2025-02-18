import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.c_blue,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.c_black),
      bodyMedium: TextStyle(color: AppColors.c_darkmode),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.blueGrey,
    scaffoldBackgroundColor: AppColors.c_black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.c_white),
      bodyMedium: TextStyle(color: AppColors.c_white70),
    ),
  );
}
