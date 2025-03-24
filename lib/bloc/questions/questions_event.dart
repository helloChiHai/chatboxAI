import 'package:equatable/equatable.dart';
import 'package:stock_flutter/models/question_model.dart';

abstract class QuestionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveQuestionsEvent extends QuestionsEvent {
  final List<Map<String, dynamic>> questions;
  final String key;

  SaveQuestionsEvent({required this.questions, required this.key});

  @override
  List<Object?> get props => [questions];
}

class LoadQuestionEvent extends QuestionsEvent {
  final String key;

  LoadQuestionEvent({required this.key});

  @override
  List<Object?> get props => [key];
}

class ClearQuestionEvent extends QuestionsEvent {
  final String key;

  ClearQuestionEvent({required this.key});

  @override
  List<Object?> get props => [key];
}
