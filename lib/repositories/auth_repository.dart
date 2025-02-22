import 'package:dio/dio.dart';
import 'package:stock_flutter/models/user_model.dart';
import 'package:stock_flutter/services/storageService.dart';

class AuthRepository {
  final Dio dio = Dio();

  Future<User?> login(String userName, String password) async {
    try {
      final user = User.fromJson({
        'id': '1',
        'userName': 'Nguyễn Văn A',
        'email': 'admin@example.com',
        'token': 'fake_jwt_token_123456',
      });

      await StorageService.saveToken(user.token);
      return user;
    } catch (e) {
      print('Login Error: $e');
    }
    return null;
  }
  // Future<User?> login(String userName, String password) async {
  //   try {
  //     // final response = await dio.post('https://your-api.com/login',
  //     //     data: {"userName": userName, "password": password});

  //     // if (response.statusCode == 200) {
  //     //   final user = User.fromJson(response.data);
  //     //   // lưu token
  //     //   // await StorageService.saveToken(user.token);
  //     //   await StorageService.saveToken('ABC123');
  //     //   return user;
  //     // }
  //     if (userName == '' && password == '') {
  //       final user = User.fromJson({
  //         'id': 1,
  //         'name': 'Nguyễn Văn A',
  //         'email': 'admin@example.com',
  //         'token': 'fake_jwt_token_123456',
  //       });

  //       await StorageService.saveToken(user.token);
  //       return user;
  //     }
  //   } catch (e) {
  //     print('Login Error: $e');
  //   }
  //   return null;
  // }

  Future<void> logout() async {
    await StorageService.deleteToken();
  }

  Future<User?> getUserFromStorage() async {
    final token = await StorageService.getToken();

    if (token == null) return null;

    // try {
    //   final response = await dio.get(
    //     'https://your-api.com',
    //     options: Options(headers: {'Authorization': 'Bearer $token'}),
    //   );

    //   if (response.statusCode == 200) {
    //     if (response.statusCode == 200) {
    //       // ✅ Kiểm tra response có đúng kiểu không
    //       if (response.data is Map<String, dynamic>) {
    //         return User.fromJson(response.data);
    //       } else {
    //         print('Unexpected response format: ${response.data}');
    //       }
    //     } else if (response.statusCode == 401) {
    //       print('Token expired. Redirecting to login...');
    //       await StorageService.deleteToken(); // Xóa token nếu hết hạn
    //     }
    //   }
    // } catch (e) {
    //   print('Token expired or invalid: $e');
    // }

    try {
      // Giả bộ dữ liệu từ API thay vì gọi thực tế
      final responseData = {
        'id': '1',
        'userName': 'Nguyễn Văn A',
        'email': 'admin@example.com',
        'token': token,
      };

      return User.fromJson(responseData);
    } catch (e) {
      print('Token expired or invalid: $e');
    }
    return null;
  }
}
