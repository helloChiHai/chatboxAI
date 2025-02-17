import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/languageBloc/language_bloc.dart';
import 'package:stock_flutter/bloc/languageBloc/language_event.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_event.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/textFieldCus_1.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();

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
              Positioned(
                top: 350,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: themeState.themeMode == ThemeMode.light
                        ? AppColors.backgroundColor
                        : AppColors.c_black87,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      textFieldCus_1(
                          context: context, controller: email, title: 'Email'),
                      const SizedBox(height: 10),
                      textFieldCus_1(
                          context: context,
                          controller: email,
                          title: 'password'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          textCus(context: context, text: 'dontHaveAccount')
                        ],
                      )
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
}
