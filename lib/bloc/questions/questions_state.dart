import 'package:equatable/equatable.dart';
import 'package:stock_flutter/models/question_model.dart';

abstract class QuestionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionInitial extends QuestionsState {}

class QuestionLoaded extends QuestionsState {
  final List<Map<String, dynamic>> questions;
  final String key;

  QuestionLoaded({required this.questions, required this.key});

  @override
  List<Object?> get props => [questions];
}

class QuestionError extends QuestionsState {
  final String message;

  QuestionError({required this.message});

  @override
  List<Object?> get props => [message];
}
