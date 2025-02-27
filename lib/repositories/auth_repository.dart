import 'package:dio/dio.dart';
import 'package:stock_flutter/models/user_model.dart';
import 'package:stock_flutter/services/storageService.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final Dio dio = Dio();
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<User?> login(String userName, String password) async {
    try {
      var uuid = Uuid();
      String userId = uuid.v4().replaceAll('-', '').substring(0, 28);
      String token = uuid.v4();

      final user = User.fromJson({
        'id': userId,
        'userName': userName,
        'email': userName,
        'token': token,
      });

      await StorageService.saveToken(user.token);
      return user;
    } catch (e) {
      print('Login Error: $e');
    }
    return null;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null; // người dùng huỷ đăng nhâp
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final firebase_auth.AuthCredential credential =
          firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final firebase_auth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final firebase_auth.User? firebaseUser = userCredential.user;

      if (firebaseUser == null) return null;

      final token = await firebaseUser.getIdToken();

      print('token: $token');
      print('firebaseUser: $firebaseUser');

      // await StorageService.saveEmailUser(firebaseUser.email ?? '');
      await StorageService.saveToken(token ?? '');

      return User(
        id: firebaseUser.uid,
        userName: firebaseUser.displayName ?? '',
        email: firebaseUser.email ?? '',
        token: token ?? '',
        img: '123123',
      );
    } catch (e) {
      print('Error siging in with google: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> logout() async {
    await StorageService.deleteToken();
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

  // Future<User?> getUserFromStorage() async {
  //   final token = await StorageService.getToken();

  //   if (token == null) return null;

  //   // try {
  //   //   final response = await dio.get(
  //   //     'https://your-api.com',
  //   //     options: Options(headers: {'Authorization': 'Bearer $token'}),
  //   //   );

  //   //   if (response.statusCode == 200) {
  //   //     if (response.statusCode == 200) {
  //   //       // ✅ Kiểm tra response có đúng kiểu không
  //   //       if (response.data is Map<String, dynamic>) {
  //   //         return User.fromJson(response.data);
  //   //       } else {
  //   //         print('Unexpected response format: ${response.data}');
  //   //       }
  //   //     } else if (response.statusCode == 401) {
  //   //       print('Token expired. Redirecting to login...');
  //   //       await StorageService.deleteToken(); // Xóa token nếu hết hạn
  //   //     }
  //   //   }
  //   // } catch (e) {
  //   //   print('Token expired or invalid: $e');
  //   // }

  //   try {
  //     // Giả bộ dữ liệu từ API thay vì gọi thực tế
  //     final responseData = {
  //       'id': '1',
  //       'userName': 'Nguyễn Văn A',
  //       'email': 'admin@example.com',
  //       'token': token,
  //     };

  //     return User.fromJson(responseData);
  //   } catch (e) {
  //     print('Token expired or invalid: $e');
  //   }
  //   return null;
  // }

  Future<User?> getUserFromStorage() async {
    final token = await StorageService.getToken();
    // final userEmail = await StorageService.getEmailUser();

    if (token == null) return null;

    try {
      // data khi giải nén token
      // print('data giai nen: ${Utils.decodeFirebaseToken(token)}');

      var dataTokenDecode = Utils.decodeFirebaseToken(token);

      // Giả bộ dữ liệu từ API thay vì gọi thực tế
      final responseData = {
        'id': dataTokenDecode?['user_id'] ?? '',
        'userName': dataTokenDecode?['name'] ?? '',
        'email': dataTokenDecode?['email'] ?? '',
        'token': 'token',
        'img': dataTokenDecode?['picture'] ?? '',
      };

      return User.fromJson(responseData);
    } catch (e) {
      print('Token expired or invalid: $e');
    }
    return null;
  }
}
