class ChatModel {
  final String body;
  final String role;
  final String? sessionId;
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final bool? isContext;

  ChatModel({
    required this.body,
    required this.role,
    this.sessionId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isContext,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      body: json['body'] ?? '',
      role: json['role'] ?? '',
      sessionId: json['sessionId'],
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      isContext: json['isContext'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'role': role,
      'sessionId': sessionId,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'isContext': isContext,
    };
  }
}
