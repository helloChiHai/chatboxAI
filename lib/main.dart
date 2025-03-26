import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_flutter/bloc/appearanceFinanceBloc/appearanceFinance_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_event.dart';
import 'package:stock_flutter/bloc/auth/auth_state.dart';
import 'package:stock_flutter/bloc/changeModal/changeModal_bloc.dart';
import 'package:stock_flutter/bloc/chatBloc/chat_bloc.dart';
import 'package:stock_flutter/bloc/languageBloc/language_bloc.dart';
import 'package:stock_flutter/bloc/questions/questions_bloc.dart';
import 'package:stock_flutter/bloc/scheduleBloc/schedule_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/constants/localization.dart';
import 'package:stock_flutter/repositories/appearanceFinance_repository.dart';
import 'package:stock_flutter/repositories/auth_repository.dart';
import 'package:stock_flutter/repositories/changeModal_repository.dart';
import 'package:stock_flutter/repositories/chat_repository.dart';
import 'package:stock_flutter/repositories/question_repository.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stock_flutter/services/QuestionService.dart';
import 'package:stock_flutter/services/appearanceFinanceService.dart';
import 'package:stock_flutter/services/navigation_service.dart';
import 'package:stock_flutter/services/service_locator.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  await ChatRepository.initialize();

  try {
    await Firebase.initializeApp(demoProjectId: "chatboxai-b5fb5");
  } catch (e) {
    print('Lỗi khởi tạo Firebase: $e');
  }

  await initializeNotifications();
  await requestNotificationPermission();

  final authRepository = AuthRepository();
  final chatRepository = ChatRepository();
  final changeModalRepository = ChangeModalRepository();
  final questionRepository =
      QuestionRepository(questionService: QuestionService());
  final appearanceFinanceRepository = AppearanceFinanceRepository(
      appearanceFinanceService: AppearanceFinanceService());

  runApp(MyApp(
    authRepository: authRepository,
    chatRepository: chatRepository,
    changeModalRepository: changeModalRepository,
    questionRepository: questionRepository,
    appearanceFinanceRepository: appearanceFinanceRepository,
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
  final ChangeModalRepository changeModalRepository;
  final QuestionRepository questionRepository;
  final AppearanceFinanceRepository appearanceFinanceRepository;
  const MyApp({
    required this.authRepository,
    required this.chatRepository,
    required this.changeModalRepository,
    required this.questionRepository,
    required this.appearanceFinanceRepository,
  });

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
        BlocProvider<ChangeModalBloc>(
            create: (context) =>
                ChangeModalBloc(modalRepository: changeModalRepository)),
        BlocProvider<QuestionsBloc>(
            create: (context) => QuestionsBloc(repository: questionRepository)),
        BlocProvider<AppearanceFinanceBloc>(
            create: (context) =>
                AppearanceFinanceBloc(repository: appearanceFinanceRepository)),
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
