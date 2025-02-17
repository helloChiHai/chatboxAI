import 'package:flutter/material.dart';

class Utils {
  // chuyển đổi ngôn ngữ
  // static void changeLanguage(BuildContext context, Locale locale) {
  //   context.setLocale(locale);
  // }

  // chuyển đổi mode sáng/ tối
  // static void toggleTheme(BuildContext context) {
  //   final brightness = Theme.of(context).brightness;
  //   ThemeMode newTheme =
  //       brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
  //   // cần có Bloc hoặc Provider để cập nhật trạng thái theme
  // }

  // kiểm tra email có hợp lệ hay không
  static bool isValidEmail(String email) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return regex.hasMatch(email);
  }

  // hiển thị snackbar
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // chuyển màn
  static void navigator(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }
}
