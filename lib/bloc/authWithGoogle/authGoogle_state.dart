import 'package:equatable/equatable.dart';
import 'package:stock_flutter/models/user_model.dart';

abstract class AuthGoogleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthGoogleInitial extends AuthGoogleState {}

class AuthGoogleLoading extends AuthGoogleState {}

class AuthGoogleAuthenticated extends AuthGoogleState {
  final User user;

  AuthGoogleAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthGoogleError extends AuthGoogleState {
  final String message;

  AuthGoogleError({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnAuthGoogleAuthenticated extends AuthGoogleState {}
