import 'package:stock_flutter/models/question_model.dart';

class MockData {
  // NHU CẦU CỦA NAM
  static final List<Question> questions = [
    Question(
      key: "1",
      text: "Bạn mong muốn người yêu/vợ của mình có ngoại hình như thế nào?",
      options: [
        "A. Càng đẹp càng tốt",
        "B. Dễ nhìn là được",
        "C. Không quan trọng"
      ],
    ),
    Question(
      key: "2",
      text: "Bạn thích phong cách ăn mặc của người yêu như thế nào?",
      options: ["A. Gợi cảm", "B. Nhẹ nhàng", "C. Đơn giản"],
    ),
    Question(
      key: "3",
      text: "Bạn đánh giá mức độ quan trọng của chuyện chăn gối như thế nào?",
      options: [
        "A. Rất quan trọng",
        "B. Quan trọng nhưng không tất cả",
        "C. Không quá quan trọng"
      ],
    ),
  ];
}
