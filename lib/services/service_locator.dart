import 'package:get_it/get_it.dart';
import 'package:stock_flutter/repositories/auth_repository.dart';
import 'package:stock_flutter/repositories/changeModal_repository.dart';
import 'package:stock_flutter/repositories/chat_repository.dart';
import 'package:stock_flutter/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository());
  locator.registerLazySingleton<ChatRepository>(() => ChatRepository());
  locator.registerLazySingleton<ChangeModalRepository>(
      () => ChangeModalRepository());
}
