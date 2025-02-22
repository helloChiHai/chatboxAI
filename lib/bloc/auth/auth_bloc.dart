import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/auth/auth_event.dart';
import 'package:stock_flutter/bloc/auth/auth_state.dart';
import 'package:stock_flutter/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginRequested>(onLoginRequested);
    on<LogoutRequested>(onLogoutRequested);
    on<CheckAuthStatus>(onCheckStatus);
  }

  Future<void> onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final user = await authRepository.login(event.userName, event.password);
    if (user != null) {
      emit(AuthAuthenticated(user: user));
      print('onLoginRequested: ${event.userName} ${event.password} ');
    } else {
      emit(AuthError(message: 'Sai tài khoản hoặc mật khẩu'));
    }
  }

  Future<void> onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(AuthInitial());
  }

  Future<void> onCheckStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    final user = await authRepository.getUserFromStorage();
    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthInitial());
    }
  }
}
