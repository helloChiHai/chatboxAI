import 'package:equatable/equatable.dart';

abstract class QuestionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionInitial extends QuestionsState {}

class QuestionLoaded extends QuestionsState {
  final Map<String, List<Map<String, dynamic>>> questionsMap;

  QuestionLoaded({required this.questionsMap});

  @override
  List<Object?> get props => [questionsMap];
}

class QuestionError extends QuestionsState {
  final String message;

  QuestionError({required this.message});

  @override
  List<Object?> get props => [message];
}
