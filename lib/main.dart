import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_flutter/bloc/languageBloc/language_bloc.dart';
import 'package:stock_flutter/bloc/languageBloc/language_state.dart';
import 'package:stock_flutter/bloc/scheduleBloc/schedule_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';
import 'package:stock_flutter/constants/localization.dart';
import 'package:stock_flutter/constants/theme.dart';
import 'package:stock_flutter/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInit = DarwinInitializationSettings();
  var initSettings = InitializationSettings(android: androidInit, iOS: iosInit);

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  // Yêu cầu quyền thông báo trên Android 13 trở lên
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  // ✅ Tạo kênh thông báo trước khi đặt thông báo
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'schedule_channel', // ID phải khớp với ID trong ScheduleBloc
    'Lịch nhắc',
    description: 'Kênh thông báo cho lịch hẹn',
    importance: Importance.high,
  );

  final AndroidFlutterLocalNotificationsPlugin?
      androidPlatformChannelSpecifics =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

  await androidPlatformChannelSpecifics?.createNotificationChannel(channel);

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
      BlocProvider<ScheduleBloc>(create: (context) => ScheduleBloc()),
      BlocProvider<LanguageBloc>(create: (context) => LanguageBloc()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, themeState) {
        return BlocBuilder<LanguageBloc, LanguageState>(
          buildWhen: (previous, current) => previous.locale != current.locale,
          builder: (context, languageState) {
            return MaterialApp(
              initialRoute: AppRoutes.home,
              routes: AppRoutes.routes,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeState.themeMode,
              locale: languageState.locale,
              supportedLocales: const [Locale('en'), Locale('vi')],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            );
          },
        );
      },
    );
  }
}
