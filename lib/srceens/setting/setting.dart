import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_event.dart';
import 'package:stock_flutter/bloc/auth/auth_state.dart';
import 'package:stock_flutter/bloc/changeModal/changeModal_bloc.dart';
import 'package:stock_flutter/bloc/changeModal/changeModal_event.dart';
import 'package:stock_flutter/bloc/changeModal/changeModal_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/repositories/changeModal_repository.dart';
import 'package:stock_flutter/services/service_locator.dart';
import 'package:stock_flutter/srceens/login/login.dart';
import 'package:stock_flutter/srceens/viewUserInformation/bgUserInformation.dart';
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
  bool isShowChangeModal = false;
  late String nameModal = 'deepseek:deepseek-v3';

  @override
  void initState() {
    super.initState();
    getCurrentModal();
  }

  Future<void> getCurrentModal() async {
    String? modal = await locator<ChangeModalRepository>().getCurrentModal();

    print('modal123123: $modal');
    if (modal != null) {
      setState(() {
        nameModal = modal;
      });
    }
  }

  void handleGoback(BuildContext context) {
    Utils.navigatorGoBack(context);
  }

  // void handleChangeTheme(BuildContext context) {
  //   context.read<ThemeBloc>().add(ToggleThemeEvent());
  // }

  // void handleChangeLanguage(BuildContext context) {
  //   final currentLocale = context.read<LanguageBloc>().state.locale;
  //   final newLocale =
  //       currentLocale.languageCode == 'vi' ? Locale('en') : Locale('vi');

  //   context.read<LanguageBloc>().add(ChangeLanguage(locale: newLocale));
  // }

  void handleLogout(BuildContext context) {
    context.read<AuthBloc>().add(const LogoutRequested());
  }

  void toggleModal(BuildContext context, String modalName) {
    context.read<ChangeModalBloc>().add(ChangeModal(modalName));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AuthLoading) {
          showLoadingPage(context: context);
        } else if (authState is UnAuthState) {
          Utils.navigatorPushAndRemoveUntil(
              context, const LoginPage(), (route) => false);
        }
      },
      builder: (context, authState) {
        return BlocBuilder<ChangeModalBloc, ModalState>(
          builder: (context, modalState) {
            final String? currentModal = modalState.currentModal ?? nameModal;
            return Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: isShowChangeModal
                      ? MediaQuery.of(context).size.height * 0.4
                      : MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    color: AppColors.c_gray_255_217,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => handleGoback(context),
                            child: const Icon(
                              Icons.close,
                              size: 25,
                              color: AppColors.c_black,
                            ),
                          ),
                          textCus(
                            context: context,
                            text: 'appName',
                            color: AppColors.c_black,
                            fontWeight: FontWeight.w600,
                            fontSize: AppSizeText.sizeText14,
                          ),
                          const Icon(
                            Icons.close,
                            size: 25,
                            color: AppColors.c_gray_255_217,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const BgUserInformation(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              BtnOptionSettingCus(
                                fnPress: () {},
                                title: 'setting',
                                icon: Icons.settings,
                              ),
                              const SizedBox(height: 10),
                              BtnOptionSettingCus(
                                fnPress: () {
                                  setState(() {
                                    isShowChangeModal = !isShowChangeModal;
                                  });
                                },
                                title: 'switchModal',
                                icon: Icons.change_circle_outlined,
                              ),
                              isShowChangeModal
                                  ? Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<ChangeModalBloc>()
                                                  .add(const ChangeModal(
                                                      'openai:gpt-4o-mini'));
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  currentModal ==
                                                          'openai:gpt-4o-mini'
                                                      ? Icons.radio_button_on
                                                      : Icons.radio_button_off,
                                                  color: currentModal ==
                                                          'openai:gpt-4o-mini'
                                                      ? Colors.blue[400]
                                                      : Colors.black,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: textCus(
                                                    context: context,
                                                    text: 'Gpt-4o-mini',
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          // Text(
                                          //   'Lần trước bạn đã mở: Modal ${modalState.currentModal}',
                                          //   style:
                                          //       const TextStyle(fontSize: 10),
                                          // ),
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<ChangeModalBloc>()
                                                  .add(const ChangeModal(
                                                      'deepseek:deepseek-v3'));
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  currentModal ==
                                                          'deepseek:deepseek-v3'
                                                      ? Icons.radio_button_on
                                                      : Icons.radio_button_off,
                                                  color: currentModal ==
                                                          'deepseek:deepseek-v3'
                                                      ? Colors.blue[400]
                                                      : Colors.black,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: textCus(
                                                    context: context,
                                                    text: 'DeepSeek',
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 20),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: btnCusLogin(
                                    context: context,
                                    title: 'logout',
                                    pressBtn: authState is AuthLoading
                                        ? null
                                        : () => handleLogout(context),
                                    bgColor: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stock_flutter/bloc/auth/auth_bloc.dart';
// import 'package:stock_flutter/bloc/auth/auth_event.dart';
// import 'package:stock_flutter/bloc/auth/auth_state.dart';
// import 'package:stock_flutter/constants/app_constants.dart';
// import 'package:stock_flutter/srceens/login/login.dart';
// import 'package:stock_flutter/srceens/viewUserInformation/bgUserInformation.dart';
// import 'package:stock_flutter/utils/utils.dart';
// import 'package:stock_flutter/widgets/btnCusLogin.dart';
// import 'package:stock_flutter/widgets/btnOptionSettingCus.dart';
// import 'package:stock_flutter/widgets/loadingPage.dart';
// import 'package:stock_flutter/widgets/text_cus.dart';

// void showCustomDialog(BuildContext context) {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: '',
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return SizedBox.shrink();
//     },
//     transitionBuilder: (context, animation, secondaryAnimation, child) {
//       return FadeTransition(
//         opacity: animation,
//         child: SettingPage(),
//       );
//     },
//   );
// }

// class SettingPage extends StatefulWidget {
//   const SettingPage({super.key});

//   @override
//   State<SettingPage> createState() => _SettingPageState();
// }

// class _SettingPageState extends State<SettingPage> {
//   double heightFactor = 0.9;
//   double widthFactor = 0.9;

//   void handleGoback(BuildContext context) {
//     Utils.navigatorGoBack(context);
//   }

//   // void handleChangeTheme(BuildContext context) {
//   //   context.read<ThemeBloc>().add(ToggleThemeEvent());
//   // }

//   // void handleChangeLanguage(BuildContext context) {
//   //   final currentLocale = context.read<LanguageBloc>().state.locale;
//   //   final newLocale =
//   //       currentLocale.languageCode == 'vi' ? Locale('en') : Locale('vi');

//   //   context.read<LanguageBloc>().add(ChangeLanguage(locale: newLocale));
//   // }

//   void handleLogout(BuildContext context) {
//     context.read<AuthBloc>().add(LogoutRequested());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, authState) {
//         if (authState is AuthLoading) {
//           showLoadingPage(context: context);
//         } else if (authState is UnAuthState) {
//           Utils.navigatorPushAndRemoveUntil(
//               context, LoginPage(), (route) => false);
//         }
//       },
//       builder: (context, authState) {
//         return Align(
//           alignment: Alignment.bottomCenter,
//           child: GestureDetector(
//             onVerticalDragUpdate: (details) {
//               // setState(() {
//               //   heightFactor -=
//               //       details.primaryDelta! / MediaQuery.of(context).size.height;
//               //   heightFactor = heightFactor.clamp(0.9, 1.0);

//               //   widthFactor -=
//               //       details.primaryDelta! / MediaQuery.of(context).size.width;
//               //   widthFactor = widthFactor.clamp(0.9, 1.0);
//               // });
//             },
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 50),
//               width: MediaQuery.of(context).size.width * widthFactor,
//               height: MediaQuery.of(context).size.height * heightFactor,
//               padding:
//                   EdgeInsets.only(top: 33 * (heightFactor == 0.9 ? 0 : 0.9)),
//               decoration: const BoxDecoration(
//                 color: AppColors.c_gray_255_217,
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(20),
//                     topLeft: Radius.circular(20)),
//               ),
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 child: Column(
//                   children: [
//                     // header
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () => handleGoback(context),
//                           child: Icon(
//                             Icons.close,
//                             size: 25,
//                           ),
//                         ),
//                         textCus(
//                           context: context,
//                           text: 'appName',
//                           color: AppColors.c_black,
//                           fontWeight: FontWeight.w600,
//                           fontSize: AppSizeText.sizeText14,
//                         ),
//                         Icon(Icons.close,
//                             size: 25, color: AppColors.c_gray_255_217),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     // user information
//                     BgUserInformation(),
//                     //
//                     Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 15,
//                         vertical: 10,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // BtnOptionSettingCus(
//                           //   fnPress: () => handleChangeLanguage(context),
//                           //   title: 'changeLanguage',
//                           //   icon: Icons.change_circle_outlined,
//                           //   themeMode: themeState.themeMode,
//                           // ),
//                           // SizedBox(height: 10),
//                           // BtnOptionSettingCus(
//                           //   fnPress: () => handleChangeTheme(context),
//                           //   title: 'changeTheme',
//                           //   icon: Icons.change_circle_outlined,
//                           //   themeMode: themeState.themeMode,
//                           // ),
//                           // SizedBox(height: 10),
//                           // BtnOptionSettingCus(
//                           //   fnPress: () {
//                           //     Utils.navigator(context, AppRoutes.meeting);
//                           //   },
//                           //   title: 'meet',
//                           //   icon: Icons.meeting_room_outlined,
//                           // ),
//                           // SizedBox(height: 10),
//                           BtnOptionSettingCus(
//                             fnPress: () {
//                               // Utils.navigator(
//                               //     context, AppRoutes.userInformation);
//                             },
//                             title: 'setting',
//                             icon: Icons.settings,
//                           ),
//                           // SizedBox(height: 10),
//                           // BtnOptionSettingCus(
//                           //   fnPress: () {
//                           //     Utils.navigator(
//                           //         context, AppRoutes.userInformation);
//                           //   },
//                           //   title: 'thông tin người dùng',
//                           //   icon: Icons.info_outline_rounded,
//                           // ),
//                           SizedBox(height: 20),
//                           btnCusLogin(
//                             context: context,
//                             title: 'logout',
//                             pressBtn: authState is AuthLoading
//                                 ? null
//                                 : () => handleLogout(context),
//                             bgColor: Colors.red,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
