import 'package:flutter/material.dart';
import 'package:stock_flutter/srceens/chat/chat.dart';
import 'package:stock_flutter/srceens/home/home.dart';
import 'package:stock_flutter/srceens/listQuestion/listQuestion.dart';
import 'package:stock_flutter/srceens/login/forgotPassword.dart';
import 'package:stock_flutter/srceens/login/login.dart';
import 'package:stock_flutter/srceens/login/register.dart';
import 'package:stock_flutter/srceens/login/welcome.dart';
import 'package:stock_flutter/srceens/meeting/meeting.dart';
import 'package:stock_flutter/srceens/miniTestScores/miniTestScores.dart';
import 'package:stock_flutter/srceens/userInformation/userInformation.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String meeting = '/meeting';
  static const String welcome = '/welcome';
  static const String forgotPassword = '/forgotPassword';
  static const String chat = '/chat';
  static const String userInformation = '/userInformation';
  static const String listQuestion = '/listQuestion';
  static const String miniTestScores = '/miniTestScores';

  static Route? generateRoute(RouteSettings settings) {
    Widget screen;
    switch (settings.name) {
      case home:
        screen = HomePage();
        break;
      case login:
        screen = LoginPage();
        break;
      case meeting:
        screen = MeetingPage();
        break;
      case welcome:
        screen = WelcomePage();
        break;
      case register:
        screen = RegisterPage();
        break;
      case forgotPassword:
        screen = ForgotPasswordPage();
        break;
      case chat:
        screen = ChatPage();
        break;
      case userInformation:
        screen = UserInformation();
        break;
      case listQuestion:
        final args = settings.arguments as Map<String, dynamic>;
        screen = ListQuestion(
            sex: args['sex'],
            titleHeader: args['titleHeader'],
            dataQuestion: args['dataQuestion'],
            nameQuestion: args['nameQuestion']);
        break;
      case miniTestScores:
        final args = settings.arguments as Map<String, dynamic>;
        screen = MiniTestScores(
          titleHeader: args['titleHeader'],
          typeScores: args['typeScores'],
        );
        break;
      default:
        return errorRoute();
    }
    return MaterialPageRoute(builder: (context) => screen);
  }

  static Route errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text(
            'Page not found',
          ),
        ),
      ),
    );
  }
}
