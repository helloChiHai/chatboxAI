import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_event.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/btnCusLogin.dart';
import 'package:stock_flutter/widgets/textFieldCus_1.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  String errorEmail = '';
  String errorPassword = '';

  final ScrollController scrollController = ScrollController();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode _focusNode = FocusNode();

  void handleLogin() {
    if (Utils.validateEmail(email.text.trim()) == 0) {
      setState(() {
        errorEmail = 'pleaseEnterEmail';
      });
    } else if (Utils.validateEmail(email.text.trim()) == -1) {
      setState(() {
        errorEmail = 'invalidEmail';
      });
    } else {
      setState(() {
        errorEmail = '';
      });
    }
    if (Utils.validatePassword(password.text.trim()) == 0) {
      setState(() {
        errorPassword = 'pleaseEnterPassword';
      });
    } else if (Utils.validatePassword(password.text.trim()) == -1) {
      setState(() {
        errorPassword = 'passwordIsNotQualified';
      });
    } else {
      setState(() {
        errorPassword = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
            icon: const Icon(
              Icons.brightness_6,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode,
        builder: (context, themeState) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF004AAD),
                        Color(0xFF3F9FED),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      const Image(
                        image: AssetImage(
                          'assets/imgs/logoApp.png',
                        ),
                        width: 70,
                        height: 70,
                      ),
                      textCus(
                        context: context,
                        text: 'appName',
                        textAlign: TextAlign.center,
                        fontSize: AppSizeText.sizeText14,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: scrollController,
                  child: Column(
                    children: [
                      Container(
                        height: 299,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 40, left: 10, right: 10, bottom: 45),
                        decoration: BoxDecoration(
                          color: themeState.themeMode == ThemeMode.light
                              ? AppColors.backgroundColor
                              : AppColors.c_darkmode,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            textFieldCus_1(
                                context: context,
                                controller: email,
                                title: 'Email',
                                txtError: errorEmail,
                                focusNode: focusNodeEmail),
                            const SizedBox(height: 10),
                            textFieldCus_1(
                                context: context,
                                controller: password,
                                title: 'password',
                                txtError: errorPassword,
                                obscureText: true),
                            const SizedBox(height: 15),
                            // button quên mật khẩu
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Utils.navigator(context, AppRoutes.register);
                                },
                                child: textCus(
                                  context: context,
                                  text: 'youForgotYourPassword',
                                  color: AppColors.c_blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            btnCusLogin(
                                context: context,
                                title: 'login',
                                pressBtn: handleLogin),
                            // cach dang nhap khac
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    height: 1,
                                    margin: const EdgeInsets.only(right: 10),
                                    color: AppColors.c_second_darkmode,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: textCus(
                                    context: context,
                                    text: 'or',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    height: 1,
                                    margin: const EdgeInsets.only(left: 10),
                                    color: AppColors.c_second_darkmode,
                                  ),
                                ),
                              ],
                            ),
                            // đăng nhập bằng google
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.c_second_darkmode,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                        'assets/imgs/google.png',
                                      ),
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    textCus(
                                        context: context,
                                        text: 'signInWithGoogle')
                                  ],
                                ),
                              ),
                            ),
                            // chưa có tài khoản
                            const SizedBox(height: 35),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textCus(
                                    context: context, text: 'dontHaveAccount'),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    Utils.navigator(
                                        context, AppRoutes.register);
                                  },
                                  child: textCus(
                                    context: context,
                                    text: 'register',
                                    color: AppColors.c_blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    focusNodeEmail.addListener(() {
      if (focusNodeEmail.hasFocus) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent * 0.2,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
    // focusNodePassword.addListener(() {
    //   if (focusNodePassword.hasFocus) {
    //     // Cuộn màn hình khi TextField nhận focus
    //     scrollController.animateTo(
    //       scrollController.position.maxScrollExtent,
    //       duration: Duration(milliseconds: 300),
    //       curve: Curves.easeOut,
    //     );
    //   }
    // });
  }
}
