import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stock_flutter/models/chat_model.dart';
import 'package:stock_flutter/repositories/changeModal_repository.dart';

class ChatRepository {
  static String apiKey = "sk-Au4vfFq5S1BVmJdo18B1D0Aa2f4e4d2d808e1cA366784465";
  static String url = "https://api.llm.ai.vn/v1/chat/completions";

  Future<ChatModel> sendMessage(String prompt) async {
    try {
      String currentModal = await ChangeModalRepository().getCurrentModal() ??
          'openai:gpt-4o-mini';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": currentModal,
          "messages": [
            {"role": "system", "content": "Bạn là một trợ lý AI hữu ích."},
            {"role": "user", "content": prompt},
          ],
        }),
      );

      print('currentModal: $currentModal');
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
