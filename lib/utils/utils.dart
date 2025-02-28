import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/routes/slideUpPageRoute.dart';

class Utils {
  // kiểm tra xác nhận mật khẩu có hợp lệ hay không
  static int validateConfrimPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 0; // Vui lòng nhập xác nhận mật khẩu
    }
    return confirmPassword == password ? 1 : -1; // null
  }

  // kiểm tra full name có hợp lệ hay không
  static int validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 0; // Vui lòng nhập full name
    }
    return 1;
  }

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
    return 1;
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

  // BTT: bot to top
  static void navigatorBTT(BuildContext context, String routeName) {
    Route? route = AppRoutes.generateRoute(RouteSettings(name: routeName));
    if (route != null) {
      Navigator.push(
          context,
          SlideUpPageRoute(
              page: (route as MaterialPageRoute).builder(context)));
    } else {
      debugPrint("Không tìm thấy route: $routeName");
    }
  }

  // mờ dần
  static void navigatorFadeTransition(BuildContext context, String routeName,
      {Object? arguments}) {
    Route? route = AppRoutes.generateRoute(
        RouteSettings(name: routeName, arguments: arguments));

    if (route != null && route is MaterialPageRoute) {
      Widget page = route.builder!(context); // Lấy widget từ route

      Navigator.push(
        context,
        PageRouteBuilder(
          settings: RouteSettings(name: routeName, arguments: arguments),
          transitionDuration: Duration(milliseconds: 90),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
            var slideAnimation =
                Tween(begin: Offset(0, 1), end: Offset.zero).animate(animation);

            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(position: slideAnimation, child: child),
            );
          },
        ),
      );
    } else {
      debugPrint("Không tìm thấy route: $routeName");
    }
  }

  // dùng để thay thế màn hình hiện tại bằng 1 màn hình mới mà không giữ lại màn hình cũ
  // khi sd, màn hình hiện tại sẽ bị xoá khỏi stack, nghĩa là không thể quay lại bằng nút back
  // khi nào dùng: cho login
  static void navigatorPushReplacementNamed(
      BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  // dùng để đẩy 1 màn hình mới vào và xoá nhiều màn hình trong stack theo 1 điều kiện nhất định
  // đk xoá màn hình được quy định bằng một callback fn
  // khi nào dùng: khi muốn chuyển đến 1 màn hình và xoá nhiều màn hình trước đó
  // dùng cho logout hoặc sau khi hoàn thành quá trình mua hàng và chuyển về màn hình ome mà không cần quay lại màn hình giỏ hàng
  static void navigatorPushAndRemoveUntil(
      BuildContext context, Widget widgetName, RoutePredicate routePredicate) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widgetName), routePredicate);
  }

  static void navigatorGoBack(BuildContext context) {
    // tránh lỗi khi quay lại ở màn hình đầu tiên
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // giải nén token
  static Map<String, dynamic>? decodeFirebaseToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        throw const FormatException('Token không hợp lệ');
      }

      final payload =
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      return json.decode(payload);
    } catch (e) {
      print('Lỗi giải mã token: $e');
      return null;
    }
  }
}
