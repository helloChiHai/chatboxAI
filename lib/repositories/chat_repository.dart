import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stock_flutter/models/chat_model.dart';
import 'package:stock_flutter/services/storageService.dart';

class ChatRepository {
  static String tokenUser = "";
  static String url = "https://chatbot.zeroxsolutions.com/v1/chat/sent";

  static Future<void> initialize() async {
    tokenUser = await StorageService.getToken() ?? "";
  }

  Future<ChatModel> sendMessage(String inputChat) async {
    try {
      var bodyJson = jsonEncode({
        "body": inputChat,
        "sessionId": "",
      });

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $tokenUser",
          "Content-Type": "application/json",
        },
        body: bodyJson,
      );

      print('bodyJson: $bodyJson');
      print(" API Response Body: ${response.body}");

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
