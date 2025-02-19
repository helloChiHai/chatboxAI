import 'package:flutter/material.dart';
import 'package:stock_flutter/srceens/home/home.dart';
import 'package:stock_flutter/srceens/login/forgotPassword.dart';
import 'package:stock_flutter/srceens/login/login.dart';
import 'package:stock_flutter/srceens/login/register.dart';
import 'package:stock_flutter/srceens/login/welcome.dart';
import 'package:stock_flutter/srceens/meeting/meeting.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String meeting = '/meeting';
  static const String welcome = '/welcome';
  static const String forgotPassword = '/forgotPassword';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    meeting: (context) => MeetingPage(),
    welcome: (context) => WelcomePage(),
    register: (context) => RegisterPage(),
    forgotPassword: (context) => ForgotPasswordPage(),
  };
}
