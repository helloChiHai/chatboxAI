class ChatModel {
  final String role;
  final String content;

  ChatModel({
    required this.role,
    required this.content,
  });

  // chuyển từ map -> chatModel
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(role: json["role"], content: json["content"]);
  }

  // chuyển từ chatmodel -> map
  Map<String, dynamic> toJson() {
    return {
      "role": role,
      "content": content,
    };
  }
}
