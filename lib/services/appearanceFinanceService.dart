import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppearanceFinanceService {
  Future<void> saveAppearanceFinance(
      String key, List<Map<String, dynamic>> questions) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> encodedQuestions =
        questions.map((q) => jsonEncode(q)).toList();
    await prefs.setStringList(key, encodedQuestions);
  }

  Future<List<Map<String, dynamic>>> getAppearanceFinance(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? encodedQuestions = prefs.getStringList(key);

    if (encodedQuestions == null) return [];

    return encodedQuestions
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
  }

  Future<void> clearAppearanceFinance(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
