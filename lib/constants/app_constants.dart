import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = "Stock App";
  static const String apiBaseUrl = "";
}

class AppColors {
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color c_darkmode = Color.fromARGB(255, 26, 25, 25);
  static const Color c_second_darkmode =
      Color(0xFF1F1F1F); // màu tối hơn để tạo sự phân biệt
  static const Color c_black = Colors.black;
  static const Color c_blue = Colors.blue;
  static const Color c_white = Colors.white;
  static const Color c_white70 = Colors.white70;
  static const Color blueGrey = Colors.blueGrey;
  static const Color c_3399FF = Color.fromARGB(255, 58, 115, 172);
  static const Color c_FF0033 = Color(0xFFFF0033);
}

class AppSizeText {
  static const double sizeText11 = 11;
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
