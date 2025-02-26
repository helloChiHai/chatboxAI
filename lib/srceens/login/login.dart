import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_event.dart';
import 'package:stock_flutter/bloc/auth/auth_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/btnCusLogin.dart';
import 'package:stock_flutter/widgets/loadingPage.dart';
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
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  String errorEmail = '';
  String errorPassword = '';
  bool isShowPassword = true;
  bool isShowLoading = false;

  bool checkInput() {
    if (Utils.validateEmail(email.text.trim()) == 1 &&
        Utils.validatePassword(password.text.trim()) == 1) {
      setState(() {
        errorEmail = '';
        errorPassword = '';
      });
      return true;
    } else {
      setState(() {
        errorEmail = Utils.validateEmail(email.text.trim()) == 0
            ? 'pleaseEnterEmail'
            : Utils.validateEmail(email.text.trim()) == -1
                ? 'invalidEmail'
                : '';

        errorPassword = Utils.validatePassword(password.text.trim()) == 0
            ? 'pleaseEnterPassword'
            : Utils.validatePassword(password.text.trim()) == -1
                ? 'passwordIsNotQualified'
                : '';
      });
      return false;
    }
  }

  void handleLogin() {
    // if (checkInput()) {
    //   showLoadingPage(context: context);

    //   // giả bộ dăng nhập mất 3s
    //   await Future.delayed(Duration(seconds: 3));

    //   // đóng modal loading
    //   Navigator.of(context).pop();

    //   print('chuyen vao man hinh home neu dang nhap thanh cong');
    // }
    context.read<AuthBloc>().add(LoginRequested(
          userName: email.text,
          password: password.text,
        ));
  }

  void signInGoogle() {
    context.read<AuthBloc>().add(GoogleSignInRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is AuthLoading) {
            isShowLoading = authState.onOffLoading;
            if (authState.onOffLoading) {
              showLoadingPage(context: context);
            } else {
              Navigator.of(context).pop();
            }
          } else if (authState is AuthAuthenticated) {
            Utils.navigatorPushReplacementNamed(context, AppRoutes.home);
          } else if (authState is AuthError) {
            Utils.showSnackBar(context, authState.message);
          }
        },
        builder: (context, authState) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              decoration: BoxDecoration(
                color: ThemeMode.system != ThemeMode.light
                    ? AppColors.backgroundColor
                    : AppColors.c_darkmode,
              ),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Image(
                        image: AssetImage('assets/imgs/logoApp.png'),
                        width: 70,
                        height: 70,
                        color: AppColors.c_darkmode
                        // color: themeState.themeMode == ThemeMode.light
                        //     ? AppColors.c_darkmode
                        //     : AppColors.backgroundColor,
                        ),
                    textCus(
                      context: context,
                      text: 'appName',
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizeText.sizeText14,
                    ),
                    const SizedBox(height: 50),
                    textCus(
                      context: context,
                      text: 'login',
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizeText.sizeText17,
                    ),
                    const SizedBox(height: 20),
                    textFieldCus_1(
                      context: context,
                      controller: email,
                      title: 'Email',
                      txtError: errorEmail,
                      focusNode: emailNode,
                      isAutofocus: false,
                    ),
                    const SizedBox(height: 10),
                    textFieldCus_1(
                      context: context,
                      controller: password,
                      title: 'password',
                      txtError: errorPassword,
                      voidCallback: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      onOffIcon: isShowPassword,
                      showIcon: true,
                      iconOff: Icons.visibility_off,
                      iconOn: Icons.visibility,
                      isAutofocus: false,
                      focusNode: passwordNode,
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Utils.navigator(context, AppRoutes.forgotPassword);
                        },
                        child: textCus(
                          context: context,
                          text: 'youForgotYourPassword',
                          color: AppColors.c_blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    btnCusLogin(
                      context: context,
                      title: 'login',
                      // pressBtn: authState is AuthLoading ? null : handleLogin,
                      pressBtn: isShowLoading ? null : handleLogin,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: 1,
                            margin: const EdgeInsets.only(right: 10),
                            color: AppColors.c_second_darkmode,
                          ),
                        ),
                        textCus(
                          context: context,
                          text: 'or',
                          fontWeight: FontWeight.w600,
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
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: signInGoogle,
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
                              image: AssetImage('assets/imgs/google.png'),
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            textCus(context: context, text: 'signInWithGoogle'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textCus(context: context, text: 'dontHaveAccount'),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Utils.navigator(context, AppRoutes.register);
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
            ),
          );
        },
      ),
    );
  }
}
