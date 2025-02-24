import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_event.dart';
import 'package:stock_flutter/bloc/auth/auth_state.dart';
import 'package:stock_flutter/bloc/languageBloc/language_bloc.dart';
import 'package:stock_flutter/bloc/languageBloc/language_event.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_event.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/srceens/login/login.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/btnCusLogin.dart';
import 'package:stock_flutter/widgets/btnOptionSettingCus.dart';
import 'package:stock_flutter/widgets/loadingPage.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

void showCustomDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (context, animation, secondaryAnimation) {
      return SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SettingPage(),
      );
    },
  );
}

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double heightFactor = 0.9;
  double widthFactor = 0.9;

  void handleGoback(BuildContext context) {
    Utils.navigatorGoBack(context);
  }

  void handleChangeTheme(BuildContext context) {
    context.read<ThemeBloc>().add(ToggleThemeEvent());
  }

  void handleChangeLanguage(BuildContext context) {
    final currentLocale = context.read<LanguageBloc>().state.locale;
    final newLocale =
        currentLocale.languageCode == 'vi' ? Locale('en') : Locale('vi');

    context.read<LanguageBloc>().add(ChangeLanguage(locale: newLocale));
  }

  void handleLogout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AuthLoading) {
          showLoadingPage(context: context);
          // } else if (authState is AuthInitial) {
        } else if (authState is UnAuthState) {
          Utils.navigatorPushAndRemoveUntil(
              context, LoginPage(), (route) => false);
        }
      },
      builder: (context, authState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          buildWhen: (previous, current) =>
              previous.themeMode != current.themeMode,
          builder: (context, themeState) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    heightFactor -= details.primaryDelta! /
                        MediaQuery.of(context).size.height;
                    heightFactor = heightFactor.clamp(0.9, 1.0);

                    widthFactor -= details.primaryDelta! /
                        MediaQuery.of(context).size.width;
                    widthFactor = widthFactor.clamp(0.9, 1.0);
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: MediaQuery.of(context).size.width * widthFactor,
                  height: MediaQuery.of(context).size.height * heightFactor,
                  padding: EdgeInsets.only(
                      top: 33 * (heightFactor == 0.9 ? 0 : 0.9)),
                  decoration: BoxDecoration(
                    color: themeState.themeMode == ThemeMode.dark
                        ? AppColors.c_second_darkmode
                        : AppColors.c_gray_255_217,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => handleGoback(context),
                              child: Icon(
                                Icons.close,
                                size: 25,
                              ),
                            ),
                            textCus(
                              context: context,
                              text: 'appName',
                              color: themeState.themeMode == ThemeMode.dark
                                  ? AppColors.backgroundColor
                                  : AppColors.c_black,
                              fontWeight: FontWeight.w600,
                              fontSize: AppSizeText.sizeText14,
                            ),
                            Icon(
                              Icons.close,
                              size: 25,
                              color: themeState.themeMode == ThemeMode.dark
                                  ? AppColors.c_second_darkmode
                                  : AppColors.c_gray_255_217,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // user information
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              color: themeState.themeMode != ThemeMode.light
                                  ? AppColors.backgroundColor
                                  : AppColors.c_darkmode,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    'https://img.amiami.jp/images/product/review/191/TOY-RBT-4827_01.jpg?a8=YRvtwRALNEponvKc_hc6iFP2Fo9wjLvg4L0sTMfLuRzCu.zLNCuEusHcDFvoJFngVFPg_6uFSqvYuRQoNFP2tjZ5xs00000003017001'),
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textCus(
                                    context: context,
                                    text: 'Vương Chí Hải',
                                    fontSize: AppSizeText.sizeText14,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        themeState.themeMode == ThemeMode.dark
                                            ? AppColors.backgroundColor
                                            : AppColors.c_black,
                                  ),
                                  textCus(
                                    context: context,
                                    text: 'vuongchihai0711@gmail.com',
                                    fontSize: AppSizeText.sizeText14,
                                    color:
                                        themeState.themeMode == ThemeMode.dark
                                            ? AppColors.backgroundColor
                                            : AppColors.c_black_54,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        //
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BtnOptionSettingCus(
                                fnPress: () => handleChangeLanguage(context),
                                title: 'changeLanguage',
                                icon: Icons.change_circle_outlined,
                                themeMode: themeState.themeMode,
                              ),
                              SizedBox(height: 10),
                              BtnOptionSettingCus(
                                fnPress: () => handleChangeTheme(context),
                                title: 'changeTheme',
                                icon: Icons.change_circle_outlined,
                                themeMode: themeState.themeMode,
                              ),
                              SizedBox(height: 10),
                              BtnOptionSettingCus(
                                fnPress: () {
                                  Utils.navigator(context, AppRoutes.meeting);
                                },
                                title: 'meet',
                                icon: Icons.meeting_room_outlined,
                                themeMode: themeState.themeMode,
                              ),
                              SizedBox(height: 10),
                              BtnOptionSettingCus(
                                fnPress: () {
                                  Utils.navigator(
                                      context, AppRoutes.userInformation);
                                },
                                title: 'thông tin người dùng',
                                icon: Icons.info_outline_rounded,
                                themeMode: themeState.themeMode,
                              ),
                              SizedBox(height: 20),
                              btnCusLogin(
                                context: context,
                                title: 'logout',
                                pressBtn: authState is AuthLoading
                                    ? null
                                    : () => handleLogout(context),
                                bgColor: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
