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
import 'package:stock_flutter/widgets/text_cus.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFF004AAD),
              Color(0xFF3F9FED),
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 130, top: 150),
              child: textCus(
                context: context,
                text: 'welcome',
                fontSize: AppSizeText.sizeText16,
              ),
            ),
            // hình ảnh logo + tên app
            Container(
              margin: EdgeInsets.only(bottom: 80),
              child: Column(
                children: [
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
                  const SizedBox(height: 40),
                  textCus(
                    context: context,
                    text: 'textWelcome',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Utils.navigator(context, AppRoutes.login);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  textCus(
                      context: context,
                      text: 'continue',
                      fontSize: AppSizeText.sizeText14),
                  Icon(Icons.arrow_right_rounded)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
