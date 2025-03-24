import 'package:stock_flutter/services/appearanceFinanceService.dart';

class AppearanceFinanceRepository {
  final AppearanceFinanceService appearanceFinanceService;

  AppearanceFinanceRepository({required this.appearanceFinanceService});

  Future<void> saveQuestions(List<Map<String, dynamic>> questions, String key) {
    return appearanceFinanceService.saveAppearanceFinance(key, questions);
  }

  Future<List<Map<String, dynamic>>> getQuestions(String key) {
    return appearanceFinanceService.getAppearanceFinance(key);
  }

  Future<void> clearQuestion(String key) {
    return appearanceFinanceService.clearAppearanceFinance(key);
  }
}
