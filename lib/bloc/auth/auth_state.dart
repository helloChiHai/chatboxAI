import 'package:equatable/equatable.dart';
import 'package:stock_flutter/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  // true: on; false: off
  bool onOffLoading;

  AuthLoading({required this.onOffLoading});

  @override
  List<Object?> get props => [onOffLoading];
}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnAuthState extends AuthState {}
