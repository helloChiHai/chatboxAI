import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stock_flutter/models/chat_model.dart';

class ChatRepository {
  static String apiKey = "sk-zTa8tij4Nyi5yDC5Dd935aF252Cd4dF985950e722101E6E5";
  static String url = "https://api.llm.ai.vn/v1/chat/completions";

  Future<ChatModel> sendMessage(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "deepseek:deepseek-v3",
          "messages": [
            {"role": "system", "content": "Bạn là một trợ lý AI hữu ích."},
            {"role": "user", "content": prompt},
          ],
        }),
      );

      print("📡 API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        var chatResponse = ChatModel(
          role: "assistant",
          content: data["choices"][0]["message"]["content"],
        );

        return chatResponse;
      } else {
        throw Exception("Lỗi API: ${response.body}");
      }
    } catch (e) {
      throw Exception("Lỗi kết nối API: $e");
    }
  }
}
