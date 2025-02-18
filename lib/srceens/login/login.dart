import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/languageBloc/language_bloc.dart';
import 'package:stock_flutter/bloc/languageBloc/language_event.dart';
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
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  String errorEmail = '';
  String errorPassword = '';
  bool isShowPassword = false;

  void handleLogin() {
    setState(() {
      errorEmail = Utils.validateEmail(email.text.trim()) == 0
          ? 'pleaseEnterEmail'
          : Utils.validateEmail(email.text.trim()) == -1
              ? 'invalidEmail'
              : '';

      errorPassword = Utils.validatePassword(password.text.trim()) == 0
          ? 'pleaseEnterPassword'
          : Utils.validateEmail(password.text.trim()) == -1
              ? 'passwordIsNotQualified'
              : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final currentLocale = context.read<LanguageBloc>().state.locale;
              final newLocale = currentLocale.languageCode == 'vi'
                  ? Locale('en')
                  : Locale('vi');
              context
                  .read<LanguageBloc>()
                  .add(ChangeLanguage(locale: newLocale));
            },
            icon: const Icon(
              Icons.language,
            ),
          ),
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
                    const SizedBox(height: 30),
                    const Image(
                      image: AssetImage('assets/imgs/logoApp.png'),
                      width: 70,
                      height: 70,
                    ),
                    textCus(
                      context: context,
                      text: 'appName',
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizeText.sizeText14,
                    ),
                    const SizedBox(height: 100),
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
                      isAutofocus: true,
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
                      showIcon: true,
                      iconOff: Icons.visibility_off,
                      iconOn: Icons.visibility,
                      isAutofocus: true,
                      focusNode: passwordNode,
                    ),
                    const SizedBox(height: 15),
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
                      pressBtn: handleLogin,
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
