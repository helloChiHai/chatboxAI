import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_flutter/bloc/auth/auth_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_event.dart';
import 'package:stock_flutter/bloc/auth/auth_state.dart';
import 'package:stock_flutter/bloc/chatBloc/chat_bloc.dart';
import 'package:stock_flutter/bloc/languageBloc/language_bloc.dart';
import 'package:stock_flutter/bloc/scheduleBloc/schedule_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/constants/localization.dart';
import 'package:stock_flutter/repositories/auth_repository.dart';
import 'package:stock_flutter/repositories/chat_repository.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stock_flutter/services/navigation_service.dart';
import 'package:stock_flutter/services/service_locator.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(demoProjectId: "chatboxai-b5fb5");
  } catch (e) {
    print('Lỗi khởi tạo Firebase: $e');
  }

  await initializeNotifications();
  await requestNotificationPermission();

  final authRepository = AuthRepository();
  final chatRepository = ChatRepository();

  runApp(MyApp(
    authRepository: authRepository,
    chatRepository: chatRepository,
  ));
}

// khỏi tạo thông báo cục bộ
Future<void> initializeNotifications() async {
  var initSettings = const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'schedule_channel',
    'Lịch nhắc',
    description: 'Kênh thông báo cho lịch hẹn',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

// yêu cầu quyền thông báo cho android 13+
Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final ChatRepository chatRepository;
  const MyApp({required this.authRepository, required this.chatRepository});

  NavigatorState get _navigator =>
      locator<NavigationService>().navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(CheckAuthStatus()),
        ),
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<ScheduleBloc>(create: (context) => ScheduleBloc()),
        BlocProvider<LanguageBloc>(create: (context) => LanguageBloc()),
        BlocProvider<ChatBloc>(create: (context) => ChatBloc(chatRepository)),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            initialRoute: AppRoutes.login,
            onGenerateRoute: AppRoutes.generateRoute,
            navigatorKey: locator<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.system,
            locale: const Locale('vi'),
            supportedLocales: const [Locale('en'), Locale('vi')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              return BlocListener<AuthBloc, AuthState>(
                listener: (context, authState) {
                  if (authState is AuthError) {
                  } else if (authState is AuthAuthenticated) {
                    _navigator.pushNamedAndRemoveUntil(
                      AppRoutes.home,
                      (route) => false,
                    );
                  } else if (authState is UnAuthState) {
                    _navigator.pushNamedAndRemoveUntil(
                      AppRoutes.login,
                      (route) => false,
                    );
                  }
                },
                child: child,
              );
            },
          );
        },
      ),
    );
  }
}
