// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
// import 'package:stock_flutter/bloc/themeBloc/theme_event.dart';
// import 'package:stock_flutter/constants/app_constants.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("welcome".tr()),
//         actions: [
//           IconButton(
//             onPressed: () {
//               context.read<ThemeBloc>().add(ToggleThemeEvent());
//             },
//             icon: Icon(
//               Icons.brightness_6,
//             ),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "hello".tr(),
//               style: TextStyle(
//                 fontSize: AppSizeText.sizeText14,
//                 color: AppColors.c_black,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 context.setLocale(
//                   Locale('vi', 'VN'),
//                 );
//               },
//               child: Text(
//                 "Tieng Viet",
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 context.setLocale(
//                   Locale('en', 'US'),
//                 );
//               },
//               child: Text(
//                 "Tieng Anh",
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
