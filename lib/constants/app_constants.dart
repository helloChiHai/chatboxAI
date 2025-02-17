import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = "Stock App";
  static const String apiBaseUrl = "";
}

class AppColors {
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color accentColor = Color(0xFFFF5722);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color c_black = Colors.black;
  static const Color c_black87 = Colors.black87;
  static const Color c_blue = Colors.blue;
  static const Color c_white = Colors.white;
  static const Color c_white70 = Colors.white70;
  static const Color blueGrey = Colors.blueGrey;
  static const Color c_3399FF = Color(0xFF3399FF);
}

class AppSizeText {
  static const double sizeText12 = 12;
  static const double sizeText14 = 14;
  static const double sizeText15 = 15;
  static const double sizeText16 = 16;
  static const double sizeText17 = 17;
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: AppSizeText.sizeText14,
    fontWeight: FontWeight.bold,
    color: AppColors.c_black,
  );
}
