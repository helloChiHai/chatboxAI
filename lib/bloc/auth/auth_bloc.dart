import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_event.dart';
import 'package:stock_flutter/bloc/auth/auth_state.dart';
import 'package:stock_flutter/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(onLoginRequested);
    on<GoogleSignInRequested>(onSignInGoogleRequested);
    on<LogoutRequested>(onLogoutRequested);
    on<CheckAuthStatus>(onCheckStatus);
  }

  Future<void> onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await Future.delayed(Duration(seconds: 2));

    final user = await authRepository.login(event.userName, event.password);
    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthError(message: 'Sai tài khoản hoặc mật khẩu'));
    }
  }

  Future<void> onSignInGoogleRequested(
      GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await authRepository.signInWithGoogle();

      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthError(message: 'Đăng nhập không thành công'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await Future.delayed(Duration(seconds: 1));

    await authRepository.logout();
    await authRepository.signOut();

    // emit(AuthInitial());
    emit(UnAuthState());
  }

  Future<void> onCheckStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    final user = await authRepository.getUserFromStorage();
    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      // emit(AuthInitial());
      emit(UnAuthState());
    }
  }
}
