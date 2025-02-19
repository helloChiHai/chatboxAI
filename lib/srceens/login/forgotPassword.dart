import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/btnCusLogin.dart';
import 'package:stock_flutter/widgets/loadingPage.dart';
import 'package:stock_flutter/widgets/textFieldCus_1.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController email = TextEditingController();
  final FocusNode emailNode = FocusNode();

  String errorEmail = '';

  bool checkInput() {
    if (Utils.validateEmail(email.text.trim()) == 1) {
      setState(() {
        errorEmail = '';
      });
      return true;
    } else {
      setState(() {
        errorEmail = Utils.validateEmail(email.text.trim()) == 0
            ? 'pleaseEnterEmail'
            : Utils.validateEmail(email.text.trim()) == -1
                ? 'invalidEmail'
                : '';
      });
      return false;
    }
  }

  void handleResetPassword() async {
    if (checkInput()) {
      showLoadingPage(context: context);

      // giả bộ dăng nhập mất 3s
      await Future.delayed(Duration(seconds: 3));

      // đóng modal loading
      Navigator.of(context).pop();

      Utils.navigatorGoBack(context);
      print('tro ve man hinh home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode,
        builder: (context, themeState) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              decoration: BoxDecoration(
                color: themeState.themeMode == ThemeMode.light
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Utils.navigatorGoBack(context);
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 0.1,
                      decoration:
                          BoxDecoration(color: AppColors.c_second_darkmode),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textCus(
                        context: context,
                        text: 'youForgotYourPassword2',
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizeText.sizeText17,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textCus(
                        context: context,
                        text:
                            'pleaseEnterYourRegisteredEmailWeWillSendPasswordReset',
                        fontSize: AppSizeText.sizeText12,
                      ),
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
                    const SizedBox(height: 60),
                    btnCusLogin(
                      context: context,
                      title: 'resetPassword',
                      pressBtn: handleResetPassword,
                    )
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
