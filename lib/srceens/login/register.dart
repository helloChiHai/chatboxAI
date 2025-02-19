import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
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
  bool isShowPassword = true;
  bool isShowConfirmPassword = true;

  void handleSignUp() {
    setState(() {
      errorName = Utils.validateName(name.text.trim()) == 0
          ? 'pleaseEnterFullName'
          : '';

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

      errorConfirmPassword = Utils.validateConfrimPassword(
                  password.text.trim(), confirmPassword.text.trim()) ==
              0
          ? 'pleaseEnterConfirmPassword'
          : Utils.validateConfrimPassword(
                      password.text.trim(), confirmPassword.text.trim()) ==
                  -1
              ? 'passwordsAreNotTheSame'
              : '';
    });
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
                    const SizedBox(height: 30),
                    Image(
                      image: AssetImage('assets/imgs/logoApp.png'),
                      width: 70,
                      height: 70,
                      color: themeState.themeMode == ThemeMode.light
                          ? AppColors.c_darkmode
                          : AppColors.backgroundColor,
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
                      isAutofocus: false,
                    ),
                    const SizedBox(height: 10),
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
                      onOffIcon: isShowConfirmPassword,
                      showIcon: true,
                      iconOff: Icons.visibility_off,
                      iconOn: Icons.visibility,
                      isAutofocus: false,
                      focusNode: confirmPasswordNode,
                    ),
                    const SizedBox(height: 60),
                    btnCusLogin(
                      context: context,
                      title: 'signUp',
                      pressBtn: handleSignUp,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textCus(context: context, text: 'areadyHaveAccount'),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Utils.navigatorGoBack(context);
                          },
                          child: textCus(
                            context: context,
                            text: 'signIn',
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
