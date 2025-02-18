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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final FocusNode nameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  String errorName = '';
  String errorEmail = '';
  String errorPassword = '';
  String errorConfirmPassword = '';
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

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
                      text: 'register',
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizeText.sizeText17,
                    ),
                    const SizedBox(height: 20),
                    textFieldCus_1(
                      context: context,
                      controller: name,
                      title: 'name',
                      txtError: errorName,
                      focusNode: nameNode,
                      isAutofocus: true,
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    textFieldCus_1(
                      context: context,
                      controller: confirmPassword,
                      title: 'confirmPassword',
                      txtError: errorConfirmPassword,
                      voidCallback: () {
                        setState(() {
                          isShowConfirmPassword = !isShowConfirmPassword;
                        });
                      },
                      showIcon: true,
                      iconOff: Icons.visibility_off,
                      iconOn: Icons.visibility,
                      isAutofocus: true,
                      focusNode: confirmPasswordNode,
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
                        textCus(context: context, text: 'areadyHaveAccount'),
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
