import 'package:flutter/material.dart';

class Utils {
  // kiểm tra email có hợp lệ hay không
  static int validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 0; // Vui lòng nhập email
    }
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return -1; // 'Email không hợp lệ'
    }
    return 1; // null
  }

  // kiểm tra phải là mật khẩu tiêu chuẩn hay không
  // Tiêu chuẩn mật khẩu:
  // Tối thiểu 8 ký tự
  // Ít nhất một chữ cái viết hoa
  // Ít nhất một chữ cái viết thường
  // Ít nhất một số
  // Ít nhất một ký tự đặc biệt
  static int validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 0;
    }
    String pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    return RegExp(pattern).hasMatch(password) ? 1 : -1;
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
