import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionService {
  Future<void> saveQuestions(
      String key, List<Map<String, dynamic>> questions) async {
    final prefs = await SharedPreferences.getInstance();
    print('key luu: $key');

    List<String> encodedQuestions =
        questions.map((q) => jsonEncode(q)).toList();
    await prefs.setStringList(key, encodedQuestions);
  }

  Future<List<Map<String, dynamic>>> getQuestions(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? encodedQuestions = prefs.getStringList(key);

    print('key nhan: $key');

    if (encodedQuestions == null) return [];

    return encodedQuestions
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
  }

  Future<void> clearQuestions(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
