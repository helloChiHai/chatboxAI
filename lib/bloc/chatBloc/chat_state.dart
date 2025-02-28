import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final String message;

  ChatSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChatError extends ChatState {
  final String error;

  ChatError({required this.error});

  @override
  List<Object?> get props => [error];
}
