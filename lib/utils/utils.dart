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
  static void navigator(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
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

  static int tinhDiemPhuHop(
      List<Map<String, dynamic>> dataNam,
      List<Map<String, dynamic>> dataNu,
      Map<int, Map<String, int>> diemTheoKey) {
    Map<int, String> mapNam = {
      for (var item in dataNam)
        int.parse(item['key'].toString()): item['selectedOption']
    };
    Map<int, String> mapNu = {
      for (var item in dataNu)
        int.parse(item['key'].toString()): item['selectedOption']
    };

    int totalScore = 0;
    int matchCount = 0;

    print('--- Kết quả so khớp ---');

    // Duyệt qua từng key chung
    for (var key in mapNam.keys) {
      if (mapNu.containsKey(key) && diemTheoKey.containsKey(key)) {
        String selectedNam = mapNam[key]!;
        String selectedNu = mapNu[key]!;
        String pair = '$selectedNam-$selectedNu';

        // Lấy điểm từ bảng điểm theo từng key
        int score = diemTheoKey[key]?[pair] ?? 0;
        print('Key $key: $selectedNam - $selectedNu => Điểm: $score');

        totalScore += score;
        matchCount++;
      }
    }

    double averageScore = matchCount > 0 ? totalScore / matchCount : 0;

    print('-------------------------');
    print('Tổng điểm: $totalScore');
    print('Điểm trung bình: ${averageScore.toStringAsFixed(2)}');

    return totalScore;
  }

  static int tinhDiemChieuCao(int chieuCaoNam, int chieuCaoNu) {
    int chenhLech = chieuCaoNam - chieuCaoNu;

    if (chenhLech >= 10 && chenhLech <= 20) {
      return 30; //  Hoàn hảo
    } else if ((chenhLech >= 5 && chenhLech < 10) ||
        (chenhLech > 20 && chenhLech <= 25)) {
      return 25;
    } else if (chenhLech > 25 && chenhLech <= 30) {
      return 15; //  Giảm điểm
    } else if (chenhLech < 5 && chenhLech >= 0) {
      return 10; // Điểm thấp
    } else {
      return 0; // Nam thấp hơn nữ
    }
  }

  /// Tính BMI dựa trên cân nặng (kg) và chiều cao (cm)
  static double tinhBMI(int canNang, int chieuCao) {
    double chieuCaoMet = chieuCao / 100.0; // Chuyển đổi cm -> m
    return canNang / (chieuCaoMet * chieuCaoMet);
  }

  /// Tính điểm BMI dựa trên BMI của nam, BMI của nữ và sở thích vóc dáng của nữ
  static int tinhDiemBMI(double bmiNam, String soThichNu) {
    // Định nghĩa các khoảng BMI theo sở thích
    Map<String, List<double>> tieuChuan = {
      "Gầy": [16, 18.5],
      "Bình thường": [18.5, 24],
      "Đầy đặn": [24, 27],
      "Mập mạp": [27, 30],
    };

    if (!tieuChuan.containsKey(soThichNu)) {
      return 10; // Nếu sở thích không hợp lệ, cho điểm trung bình thấp
    }

    List<double> khoangThichHop = tieuChuan[soThichNu]!;
    double minThichHop = khoangThichHop[0];
    double maxThichHop = khoangThichHop[1];

    if (bmiNam >= minThichHop && bmiNam <= maxThichHop) {
      return 30; //  Trùng khớp hoàn toàn
    } else if ((bmiNam >= minThichHop - 2 && bmiNam < minThichHop) ||
        (bmiNam > maxThichHop && bmiNam <= maxThichHop + 2)) {
      return 20; // Lệch 1-2 đơn vị BMI
    } else if ((bmiNam >= minThichHop - 4 && bmiNam < minThichHop - 2) ||
        (bmiNam > maxThichHop + 2 && bmiNam <= maxThichHop + 4)) {
      return 10; //  Không đúng sở thích
    } else {
      return 5; //  Lệch hoàn toàn
    }
  }

  /// Tính điểm thu nhập của nam so với nữ
  static int tinhDiemThuNhap(double thuNhapNam, double thuNhapNu) {
    if (thuNhapNam == 0) return 0; //  Nam thất nghiệp
    double tyLe = thuNhapNam / thuNhapNu;
    if (tyLe >= 1.5) return 30; //  Nam kiếm ≥ 1.5 lần nữ
    if (tyLe >= 1.0) return 20; // Nam kiếm từ 1.0 - 1.49 lần nữ
    if (tyLe >= 0.7) return 10; //  Nam kiếm ít hơn nữ nhưng trên 70%
    return 5; //  Nam kiếm < 70% nữ
  }

  /// Tính điểm chênh lệch tuổi tác
  static int tinhDiemTuoi(int tuoiNam, int tuoiNu) {
    int chenhLech = tuoiNam - tuoiNu;
    if (chenhLech >= 2 && chenhLech <= 7) return 10; //  Nam hơn nữ 2-7 tuổi
    if (chenhLech >= 8 && chenhLech <= 10) return 6; //  Nam hơn nữ 8-10 tuổi
    if (chenhLech > 10) return 2; //  Nam hơn nữ trên 10 tuổi
    return 0; //  Nam bằng hoặc nhỏ hơn nữ
  }

  static String tinhTongDiem({
    required int chieuCaoNam,
    required int chieuCaoNu,
    required int canNangNam,
    required String soThichNu,
    required double thuNhapNam,
    required double thuNhapNu,
    required int tuoiNam,
    required int tuoiNu,
  }) {
    int diemChieuCao = tinhDiemChieuCao(chieuCaoNam, chieuCaoNu);
    double bmiNam = tinhBMI(canNangNam, chieuCaoNam);
    int diemBMI = tinhDiemBMI(bmiNam, soThichNu);
    int diemThuNhap = tinhDiemThuNhap(thuNhapNam, thuNhapNu);
    int diemTuoi = tinhDiemTuoi(tuoiNam, tuoiNu);

    int tongDiem = diemChieuCao + diemBMI + diemThuNhap + diemTuoi;

    if (tongDiem > 85) return "Siêu hợp 💖 ($tongDiem điểm)";
    if (tongDiem >= 70) return "Rất hợp 👍 ($tongDiem điểm)";
    if (tongDiem >= 50) return "Bình thường 🤔 ($tongDiem điểm)";
    if (tongDiem >= 30) return "Tương đối khó 😬 ($tongDiem điểm)";
    return "Không hợp ❌ ($tongDiem điểm)";
  }
}
