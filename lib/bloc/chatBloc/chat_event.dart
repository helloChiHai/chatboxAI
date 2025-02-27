import 'package:equatable/equatable.dart';

class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendMessage extends ChatEvent {
  final String message;

  SendMessage({required this.message});

  @override
  List<Object?> get props => [message];
}
