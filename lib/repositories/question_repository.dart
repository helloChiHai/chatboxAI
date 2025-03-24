import 'package:stock_flutter/services/QuestionService.dart';

class QuestionRepository {
  final QuestionService questionService;

  QuestionRepository({required this.questionService});

  Future<void> saveQuestions(List<Map<String, dynamic>> questions, String key) {
    return questionService.saveQuestions(key, questions);
  }

  Future<List<Map<String, dynamic>>> getQuestions(String key) {
    return questionService.getQuestions(key);
  }

  Future<void> clearQuestion(String key) {
    return questionService.clearQuestions(key);
  }
}
