import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_event.dart';
import 'package:stock_flutter/bloc/auth/auth_state.dart';
import 'package:stock_flutter/repositories/auth_repository.dart';
import 'package:stock_flutter/services/service_locator.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(onLoginRequested);
    on<GoogleSignInRequested>(onSignInGoogleRequested);
    on<LogoutRequested>(onLogoutRequested);
    on<CheckAuthStatus>(onCheckStatus);
  }

  Future<void> onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(onOffLoading: true));

    await Future.delayed(Duration(seconds: 1));

    final user =
        await locator<AuthRepository>().login(event.userName, event.password);
    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthLoading(onOffLoading: false));
      emit(AuthError(message: 'Vui lòng kiểm tra lại tài khoản hoặc mật khẩu'));
    }
  }

  Future<void> onSignInGoogleRequested(
      GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(onOffLoading: true));

    try {
      final user = await locator<AuthRepository>().signInWithGoogle();

      if (user != null) {
        print('user: $user');
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthLoading(onOffLoading: false));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(onOffLoading: true));
    await locator<AuthRepository>().logout();
    await locator<AuthRepository>().signOut();
    emit(AuthLoading(onOffLoading: false));

    emit(UnAuthState());
  }

  Future<void> onCheckStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    final user = await locator<AuthRepository>().getUserFromStorage();
    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(UnAuthState());
    }
  }
}
