import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// đăng nhập bằng tk bình thường
class LoginRequested extends AuthEvent {
  final String userName;
  final String password;

  const LoginRequested({required this.userName, required this.password});

  @override
  List<Object?> get props => [userName, password];
}

// đăng nhập bằng tk gg
class GoogleSignInRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}
