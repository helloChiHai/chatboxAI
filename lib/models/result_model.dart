import 'dart:convert';

import 'package:stock_flutter/models/question_model.dart';
import 'package:stock_flutter/models/userInformation_model.dart';

class ResultModel {
  final String key;
  final UserInformationModel informationUser;
  final List<Question> listQuestion;

  ResultModel({
    required this.key,
    required this.informationUser,
    required this.listQuestion,
  });

  // Chuyển từ JSON thành đối tượng
  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      key: json['key'],
      informationUser: UserInformationModel.fromJson(json['informationUser']),
      listQuestion: (json['listQuestion'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }

  // Chỉ trả về key và selectedOption của mỗi Question
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'informationUser': informationUser.toJson(),
      'listQuestion': listQuestion.map((q) {
        return {
          'key': q.key,
          'selectedOption': q.selectedOption ?? "Chưa chọn",
        };
      }).toList(),
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
