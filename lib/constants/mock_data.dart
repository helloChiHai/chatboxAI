import 'package:stock_flutter/models/question_model.dart';

class MockData {
  // NHU CẦU CỦA NAM
  static final List<Question> dataNhuCauNam = [
    Question(
      key: "1",
      text: "Bạn mong muốn người yêu/vợ của mình có ngoại hình như thế nào?",
      options: [
        "A. Càng đẹp càng tốt, tôi rất quan tâm đến ngoại hình.",
        "B. Dễ nhìn là được, không cần quá xuất sắc.",
        "C. Tôi không quan trọng ngoại hình, chỉ cần hợp tính."
      ],
    ),
    Question(
      key: "2",
      text: "Bạn thích phong cách ăn mặc của người yêu như thế nào?",
      options: [
        "A. Gợi cảm, quyến rũ.",
        "B. Nhẹ nhàng, nữ tính.",
        "C. Đơn giản, năng động."
      ],
    ),
    Question(
      key: "3",
      text:
          "Bạn đánh giá mức độ quan trọng của chuyện chăn gối trong mối quan hệ là bao nhiêu?",
      options: [
        "A. Rất quan trọng, ảnh hưởng lớn đến tình cảm.",
        "B. Quan trọng, nhưng không phải tất cả.",
        "C. Không quá quan trọng, cảm xúc tinh thần quan trọng hơn."
      ],
    ),
    Question(
      key: "4",
      text:
          "Bạn mong muốn tần suất quan hệ tình dục trong mối quan hệ là bao nhiêu?",
      options: [
        "A. Nhiều, ít nhất vài lần một tuần.",
        "B. Vừa phải, khoảng 1-2 lần một tuần.",
        "C. Không có nhu cầu cao, chỉ khi nào cảm thấy cần thiết."
      ],
    ),
    Question(
      key: "5",
      text: "Bạn thích bạn gái/vợ của mình có kỹ năng tình dục như thế nào?",
      options: [
        "A. Thành thạo, biết cách làm chủ cuộc chơi.",
        "B. Ở mức cơ bản, không cần quá giỏi.",
        "C. Không quan trọng, miễn là có cảm xúc."
      ],
    ),
    Question(
      key: "6",
      text: "Bạn thích kiểu tương tác tình cảm nào với người yêu/vợ?",
      options: [
        "A. Hay ôm hôn, động chạm thân mật.",
        "B. Chỉ cần những cử chỉ nhỏ như nắm tay.",
        "C. Tôi không thích thể hiện tình cảm quá nhiều."
      ],
    ),
    Question(
      key: "7",
      text:
          "Bạn mong muốn người yêu/vợ mình độc lập tài chính hay phụ thuộc vào bạn?",
      options: [
        "A. Hoàn toàn độc lập, không cần dựa dẫm vào tôi.",
        "B. Kiếm tiền nhưng vẫn cần tôi hỗ trợ.",
        "C. Tôi muốn chu cấp hoàn toàn cho cô ấy."
      ],
    ),
    Question(
      key: "8",
      text: "Bạn có thích phụ nữ giỏi việc nhà không?",
      options: [
        "A. Rất thích, tôi muốn người yêu/vợ đảm đang.",
        "B. Cũng được, nhưng không quá quan trọng.",
        "C. Không cần, tôi có thể tự làm hoặc thuê người."
      ],
    ),
    Question(
      key: "9",
      text: "Bạn thích người yêu/vợ của mình có sự nghiệp như thế nào?",
      options: [
        "A. Thành đạt, có công việc và thu nhập cao.",
        "B. Ổn định, không quá áp lực.",
        "C. Ở nhà nội trợ cũng được."
      ],
    ),
    Question(
      key: "10",
      text: "Bạn có sẵn sàng giúp vợ làm việc nhà không?",
      options: [
        "A. Có, tôi thích chia sẻ công việc.",
        "B. Thỉnh thoảng, khi có thời gian.",
        "C. Không, đó là việc của cô ấy."
      ],
    ),
    Question(
      key: "11",
      text: "Bạn thích phụ nữ có tính cách như thế nào?",
      options: [
        "A. Ngọt ngào, nhẹ nhàng.",
        "B. Cá tính, mạnh mẽ.",
        "C. Biết điều, hiểu chuyện."
      ],
    ),
    Question(
      key: "12",
      text: "Bạn có thích phụ nữ hay ghen không?",
      options: [
        "A. Không, tôi ghét sự kiểm soát.",
        "B. Vừa phải, ghen nhẹ để biết yêu tôi.",
        "C. Tôi thích cô ấy phải chiếm hữu tôi hoàn toàn."
      ],
    ),
    Question(
      key: "13",
      text: "Bạn thích mẫu người yêu/vợ có chủ động trong tình yêu không?",
      options: [
        "A. Có, tôi thích phụ nữ chủ động.",
        "B. Không, tôi thích là người dẫn dắt.",
        "C. Cân bằng, cả hai cùng chủ động."
      ],
    ),
    Question(
      key: "14",
      text: "Bạn có thích bạn gái/vợ chăm sóc bạn như mẹ không?",
      options: [
        "A. Có, tôi thích được quan tâm từng chút một.",
        "B. Không, tôi tự lo được.",
        "C. Chỉ khi tôi ốm đau hoặc mệt mỏi."
      ],
    ),
    Question(
      key: "15",
      text: "Bạn thích bạn gái/vợ của mình hòa hợp với gia đình bạn không?",
      options: [
        "A. Rất quan trọng, tôi muốn cô ấy hợp với gia đình tôi.",
        "B. Chỉ cần không xung đột là được.",
        "C. Tôi không quan tâm, chỉ cần hợp với tôi."
      ],
    ),
    Question(
      key: "16",
      text: "Bạn có thích đi chơi, du lịch cùng người yêu/vợ không?",
      options: [
        "A. Có, càng nhiều càng tốt.",
        "B. Vừa phải, lâu lâu đi một lần.",
        "C. Tôi không thích du lịch lắm."
      ],
    ),
    Question(
      key: "17",
      text: "Bạn có sẵn sàng hy sinh sở thích cá nhân vì người yêu/vợ không?",
      options: [
        "A. Có, nếu điều đó quan trọng với cô ấy.",
        "B. Chỉ trong giới hạn hợp lý.",
        "C. Không, tôi muốn giữ sở thích của mình."
      ],
    ),
    Question(
      key: "18",
      text: "Bạn có thích kiểm soát người yêu/vợ không?",
      options: [
        "A. Không, tôi tôn trọng sự riêng tư.",
        "B. Chỉ muốn biết những điều quan trọng.",
        "C. Có, tôi muốn kiểm soát mọi thứ."
      ],
    ),
    Question(
      key: "19",
      text: "Bạn thích sống ở đâu sau khi kết hôn?",
      options: [
        "A. Ở riêng, không sống chung với gia đình.",
        "B. Gần nhà bố mẹ để tiện chăm sóc.",
        "C. Sống chung với gia đình chồng."
      ],
    ),
    Question(
      key: "20",
      text: "Bạn có muốn có con ngay sau khi kết hôn không?",
      options: [
        "A. Có, tôi thích có con sớm.",
        "B. Đợi một thời gian rồi tính tiếp.",
        "C. Không muốn có con hoặc chưa nghĩ tới."
      ],
    ),
  ];

  static final List<Question> dataNhuCauNu = [
    Question(
      key: "1",
      text: "Bạn mong muốn người yêu/chồng có ngoại hình như thế nào?",
      options: [
        "A. Cao to, nam tính, body đẹp.",
        "B. Gọn gàng, sáng sủa, dễ nhìn là được.",
        "C. Không quan trọng ngoại hình, quan trọng là tính cách."
      ],
    ),
    Question(
      key: "2",
      text: "Bạn thích phong cách ăn mặc của người yêu/chồng như thế nào?",
      options: [
        "A. Chỉnh chu, lịch lãm.",
        "B. Phong cách trẻ trung, năng động.",
        "C. Không quá quan tâm, miễn là sạch sẽ."
      ],
    ),
    Question(
      key: "3",
      text:
          "Bạn đánh giá mức độ quan trọng của chuyện chăn gối trong mối quan hệ là bao nhiêu?",
      options: [
        "A. Rất quan trọng, ảnh hưởng lớn đến tình cảm.",
        "B. Quan trọng, nhưng không phải tất cả.",
        "C. Không quá quan trọng, cảm xúc tinh thần quan trọng hơn."
      ],
    ),
    Question(
      key: "4",
      text:
          "Bạn mong muốn tần suất quan hệ tình dục trong mối quan hệ là bao nhiêu?",
      options: [
        "A. Nhiều, ít nhất vài lần một tuần.",
        "B. Vừa phải, khoảng 1-2 lần một tuần.",
        "C. Không có nhu cầu cao, chỉ khi nào cảm thấy cần thiết."
      ],
    ),
    Question(
      key: "5",
      text: "Bạn thích bạn trai/chồng có kỹ năng tình dục như thế nào?",
      options: [
        "A. Thành thạo, biết cách làm chủ cuộc chơi.",
        "B. Ở mức cơ bản, không cần quá giỏi.",
        "C. Không quan trọng, miễn là có cảm xúc."
      ],
    ),
    Question(
      key: "6",
      text:
          "Bạn mong muốn người yêu/chồng thể hiện tình cảm với bạn như thế nào?",
      options: [
        "A. Thường xuyên ôm hôn, động chạm.",
        "B. Vừa phải, không quá sến súa.",
        "C. Không cần thể hiện quá nhiều, quan trọng là hành động thực tế."
      ],
    ),
    Question(
      key: "7",
      text: "Bạn mong muốn người yêu/chồng có kinh tế như thế nào?",
      options: [
        "A. Giàu có, đủ khả năng lo cho tôi thoải mái.",
        "B. Ổn định, có thể tự lo cuộc sống.",
        "C. Không quan trọng, tôi có thể tự lo tài chính."
      ],
    ),
    Question(
      key: "8",
      text: "Bạn thích một người đàn ông biết làm việc nhà không?",
      options: [
        "A. Có, tôi muốn người đàn ông biết chia sẻ việc nhà.",
        "B. Không quá quan trọng, nhưng biết làm thì tốt hơn.",
        "C. Không cần, tôi có thể tự làm hoặc thuê người."
      ],
    ),
    Question(
      key: "9",
      text: "Bạn muốn bạn trai/chồng có công việc như thế nào?",
      options: [
        "A. Thành đạt, có sự nghiệp vững vàng.",
        "B. Ổn định, không cần quá giàu nhưng đủ sống tốt.",
        "C. Không quan trọng, miễn là có trách nhiệm."
      ],
    ),
    Question(
      key: "10",
      text: "Bạn thích mẫu đàn ông có tính cách như thế nào?",
      options: [
        "A. Mạnh mẽ, quyết đoán, có chính kiến.",
        "B. Tình cảm, biết quan tâm, chia sẻ.",
        "C. Hài hước, vui vẻ, biết cách làm tôi cười."
      ],
    ),
    Question(
      key: "11",
      text: "Bạn có thích đàn ông hay ghen không?",
      options: [
        "A. Không, tôi ghét sự kiểm soát.",
        "B. Vừa phải, ghen nhẹ để thể hiện sự quan tâm.",
        "C. Tôi thích anh ấy phải chiếm hữu tôi hoàn toàn."
      ],
    ),
    Question(
      key: "12",
      text: "Bạn thích đàn ông chủ động trong tình yêu không?",
      options: [
        "A. Có, tôi muốn anh ấy dẫn dắt mối quan hệ.",
        "B. Cả hai cùng chủ động, không ai áp đảo ai.",
        "C. Không, tôi thích mình là người nắm quyền kiểm soát."
      ],
    ),
    Question(
      key: "13",
      text: "Bạn có thích người yêu/chồng chăm sóc bạn như bố không?",
      options: [
        "A. Có, tôi thích được nuông chiều và bảo vệ.",
        "B. Không, tôi muốn độc lập.",
        "C. Chỉ khi tôi mệt mỏi hoặc yếu đuối."
      ],
    ),
    Question(
      key: "14",
      text: "Bạn có muốn bạn trai/chồng hòa hợp với gia đình bạn không?",
      options: [
        "A. Rất quan trọng, tôi muốn anh ấy hợp với gia đình tôi.",
        "B. Chỉ cần không xung đột là được.",
        "C. Tôi không quan tâm, chỉ cần hợp với tôi."
      ],
    ),
    Question(
      key: "15",
      text: "Bạn thích đi chơi, du lịch cùng người yêu/chồng không?",
      options: [
        "A. Có, càng nhiều càng tốt.",
        "B. Vừa phải, lâu lâu đi một lần.",
        "C. Tôi không thích du lịch lắm."
      ],
    ),
    Question(
      key: "16",
      text:
          "Bạn có sẵn sàng hy sinh sở thích cá nhân vì người yêu/chồng không?",
      options: [
        "A. Có, nếu điều đó quan trọng với anh ấy.",
        "B. Chỉ trong giới hạn hợp lý.",
        "C. Không, tôi muốn giữ sở thích của mình."
      ],
    ),
    Question(
      key: "17",
      text: "Bạn có thích kiểm soát người yêu/chồng không?",
      options: [
        "A. Không, tôi tôn trọng sự riêng tư.",
        "B. Chỉ muốn biết những điều quan trọng.",
        "C. Có, tôi muốn kiểm soát mọi thứ."
      ],
    ),
    Question(
      key: "18",
      text: "Bạn thích sống ở đâu sau khi kết hôn?",
      options: [
        "A. Ở riêng, không sống chung với gia đình.",
        "B. Gần nhà bố mẹ để tiện chăm sóc.",
        "C. Sống chung với gia đình chồng."
      ],
    ),
    Question(
      key: "19",
      text: "Bạn có muốn có con ngay sau khi kết hôn không?",
      options: [
        "A. Có, tôi thích có con sớm.",
        "B. Đợi một thời gian rồi tính tiếp.",
        "C. Không muốn có con hoặc chưa nghĩ tới."
      ],
    ),
    Question(
      key: "20",
      text: "Bạn muốn nuôi dạy con như thế nào?",
      options: [
        "A. Theo phong cách truyền thống, nghiêm khắc.",
        "B. Theo hướng hiện đại, thoải mái và tự do.",
        "C. Kết hợp cả truyền thống và hiện đại."
      ],
    ),
  ];

  //  KHẢ NĂNG
  static final List<Question> dataKhaNangCuaNam = [
    Question(
      key: "1",
      text: "Bạn có tự tin về ngoại hình của mình không?",
      options: [
        "A. Rất tự tin, tôi biết mình có sức hút.",
        "B. Bình thường, tôi không đẹp trai nhưng có duyên.",
        "C. Không tự tin lắm, ngoại hình không phải thế mạnh của tôi."
      ],
    ),
    Question(
      key: "2",
      text: "Bạn có thường xuyên chăm sóc bản thân, tập luyện thể thao không?",
      options: [
        "A. Có, tôi luôn duy trì body săn chắc, khỏe mạnh.",
        "B. Thỉnh thoảng tập, không quá nghiêm túc.",
        "C. Không quan tâm lắm, miễn là không béo phì."
      ],
    ),
    Question(
      key: "3",
      text: "Bạn có quan tâm đến phong cách ăn mặc không?",
      options: [
        "A. Có, tôi luôn ăn mặc chỉn chu, hợp thời trang.",
        "B. Tùy hoàn cảnh, khi cần thì mặc đẹp.",
        "C. Không quá quan trọng, miễn sao thoải mái là được."
      ],
    ),
    Question(
      key: "4",
      text:
          "Bạn có nghĩ rằng chuyện chăn gối là quan trọng trong mối quan hệ không?",
      options: [
        "A. Rất quan trọng, tôi luôn cố gắng để bạn gái hài lòng.",
        "B. Quan trọng nhưng không phải tất cả.",
        "C. Không quá quan trọng, quan hệ tình cảm là chính."
      ],
    ),
    Question(
      key: "5",
      text: "Bạn đánh giá kỹ năng tình dục của mình như thế nào?",
      options: [
        "A. Xuất sắc, tôi có kinh nghiệm và biết cách làm hài lòng đối phương.",
        "B. Ổn, có thể cải thiện nếu cần.",
        "C. Không có nhiều kinh nghiệm nhưng sẵn sàng học hỏi."
      ],
    ),
    Question(
      key: "6",
      text:
          "Bạn có thích thể hiện tình cảm bằng hành động (ôm, hôn, vuốt ve) không?",
      options: [
        "A. Có, tôi thích gần gũi và thể hiện tình cảm nhiều.",
        "B. Vừa phải, không quá lạm dụng.",
        "C. Không thích lắm, tôi thể hiện bằng cách khác."
      ],
    ),
    Question(
      key: "7",
      text: "Tình hình tài chính của bạn như thế nào?",
      options: [
        "A. Rất tốt, tôi có khả năng lo cho người yêu/chồng.",
        "B. Ổn định, đủ sống thoải mái.",
        "C. Đang cố gắng cải thiện tài chính."
      ],
    ),
    Question(
      key: "8",
      text: "Bạn có sẵn sàng chia sẻ việc nhà với bạn gái/vợ không?",
      options: [
        "A. Có, tôi thích làm việc nhà cùng bạn gái/vợ.",
        "B. Thỉnh thoảng, nếu cần giúp đỡ.",
        "C. Không, tôi nghĩ đó là việc của phụ nữ."
      ],
    ),
    Question(
      key: "9",
      text: "Bạn có công việc ổn định không?",
      options: [
        "A. Có, tôi có sự nghiệp vững chắc.",
        "B. Công việc bình thường, không quá xuất sắc.",
        "C. Chưa ổn định, đang trên đường phát triển."
      ],
    ),
    Question(
      key: "10",
      text: "Bạn có phải là người quyết đoán không?",
      options: [
        "A. Có, tôi luôn biết mình muốn gì và không do dự.",
        "B. Tùy trường hợp, có lúc mạnh mẽ, có lúc do dự.",
        "C. Không, tôi hay bị ảnh hưởng bởi người khác."
      ],
    ),
    Question(
      key: "11",
      text: "Bạn có hay ghen không?",
      options: [
        "A. Có, tôi muốn kiểm soát người yêu/vợ.",
        "B. Vừa phải, chỉ khi có dấu hiệu đáng ngờ.",
        "C. Không, tôi rất tin tưởng đối phương."
      ],
    ),
    Question(
      key: "12",
      text: "Bạn có sẵn sàng chủ động trong mối quan hệ không?",
      options: [
        "A. Có, tôi thích dẫn dắt và kiểm soát tình hình.",
        "B. Tùy lúc, có lúc chủ động, có lúc để đối phương quyết định.",
        "C. Không, tôi thích để bạn gái quyết định."
      ],
    ),
    Question(
      key: "13",
      text: "Bạn có thích chăm sóc người yêu như một cô công chúa không?",
      options: [
        "A. Có, tôi thích nuông chiều và bảo vệ cô ấy.",
        "B. Vừa phải, nhưng không muốn cô ấy quá dựa dẫm.",
        "C. Không, tôi muốn một mối quan hệ bình đẳng."
      ],
    ),
    Question(
      key: "14",
      text: "Bạn có sẵn sàng hòa hợp với gia đình bạn gái/vợ không?",
      options: [
        "A. Có, tôi luôn cố gắng tạo quan hệ tốt với gia đình cô ấy.",
        "B. Chỉ cần không xung đột là được.",
        "C. Không quan tâm, tôi chỉ cần hợp với cô ấy."
      ],
    ),
    Question(
      key: "15",
      text: "Bạn có thích đi chơi, du lịch với người yêu/vợ không?",
      options: [
        "A. Có, tôi thích trải nghiệm và khám phá cùng nhau.",
        "B. Vừa phải, lâu lâu đi một lần.",
        "C. Không thích du lịch lắm."
      ],
    ),
    Question(
      key: "16",
      text:
          "Bạn có sẵn sàng thay đổi sở thích cá nhân để phù hợp với người yêu không?",
      options: [
        "A. Có, nếu điều đó quan trọng với cô ấy.",
        "B. Chỉ trong giới hạn hợp lý.",
        "C. Không, tôi muốn giữ sở thích của mình."
      ],
    ),
    Question(
      key: "17",
      text: "Bạn có thích kiểm soát người yêu/vợ không?",
      options: [
        "A. Có, tôi muốn biết mọi thứ về cô ấy.",
        "B. Chỉ cần biết những điều quan trọng.",
        "C. Không, tôi tôn trọng sự riêng tư."
      ],
    ),
    Question(
      key: "18",
      text: "Bạn muốn sống ở đâu sau khi kết hôn?",
      options: [
        "A. Ở riêng, không sống chung với gia đình.",
        "B. Gần nhà bố mẹ để tiện chăm sóc.",
        "C. Sống chung với gia đình vợ."
      ],
    ),
    Question(
      key: "19",
      text: "Bạn có muốn có con ngay sau khi kết hôn không?",
      options: [
        "A. Có, tôi thích có con sớm.",
        "B. Đợi một thời gian rồi tính tiếp.",
        "C. Không muốn có con hoặc chưa nghĩ tới."
      ],
    ),
    Question(
      key: "20",
      text: "Bạn muốn nuôi dạy con như thế nào?",
      options: [
        "A. Theo phong cách truyền thống, nghiêm khắc.",
        "B. Theo hướng hiện đại, thoải mái và tự do.",
        "C. Kết hợp cả truyền thống và hiện đại."
      ],
    ),
  ];

  static final List<Question> dataKhaNangCuaNu = [
    Question(
      key: "1",
      text: "Bạn có quan tâm đến ngoại hình và chăm sóc bản thân không?",
      options: [
        "A. Có, tôi luôn giữ gìn vẻ ngoài hấp dẫn.",
        "B. Vừa phải, không quá đặt nặng.",
        "C. Không, tôi không quan tâm lắm đến ngoại hình."
      ],
    ),
    Question(
      key: "2",
      text:
          "Bạn có sẵn sàng học hỏi hoặc cải thiện kỹ năng tình dục để làm hài lòng đối phương không?",
      options: [
        "A. Có, tôi luôn sẵn sàng cải thiện.",
        "B. Nếu đối phương yêu cầu thì tôi sẽ cân nhắc.",
        "C. Không, tôi thấy không cần thiết."
      ],
    ),
    Question(
      key: "3",
      text: "Bạn có hay chủ động thể hiện tình cảm không?",
      options: [
        "A. Có, tôi thích thể hiện bằng hành động và lời nói.",
        "B. Vừa phải, không quá lộ liễu.",
        "C. Không, tôi ít khi thể hiện tình cảm."
      ],
    ),
    Question(
      key: "4",
      text: "Bạn có thường xuyên làm đẹp, trang điểm khi đi ra ngoài không?",
      options: [
        "A. Có, tôi luôn muốn mình xinh đẹp trước mặt người yêu.",
        "B. Tùy dịp, không phải lúc nào cũng trang điểm.",
        "C. Không, tôi thích vẻ đẹp tự nhiên."
      ],
    ),
    Question(
      key: "5",
      text:
          "Bạn có sẵn sàng hỗ trợ tài chính nếu chồng/bạn trai gặp khó khăn không?",
      options: [
        "A. Có, tôi sẵn sàng san sẻ.",
        "B. Chỉ trong một số trường hợp cần thiết.",
        "C. Không, tài chính là trách nhiệm của đàn ông."
      ],
    ),
    Question(
      key: "6",
      text:
          "Bạn có sẵn sàng tôn trọng và ủng hộ đam mê, sự nghiệp của bạn trai/chồng không?",
      options: [
        "A. Có, tôi sẽ luôn ủng hộ hết mình.",
        "B. Tùy vào mức độ hợp lý.",
        "C. Không, nếu nó ảnh hưởng đến cuộc sống chung."
      ],
    ),
    Question(
      key: "7",
      text:
          "Bạn có sẵn sàng dành thời gian để chăm sóc bạn trai/chồng sau một ngày làm việc mệt mỏi không?",
      options: [
        "A. Có, tôi thích chăm sóc người mình yêu.",
        "B. Chỉ khi tôi cũng không quá mệt.",
        "C. Không, ai cũng có trách nhiệm tự lo cho bản thân."
      ],
    ),
    Question(
      key: "8",
      text: "Bạn có quan tâm đến việc chăm sóc nhà cửa không?",
      options: [
        "A. Có, tôi thích giữ nhà cửa gọn gàng, sạch sẽ.",
        "B. Vừa phải, miễn là không quá bừa bộn.",
        "C. Không, tôi không thích việc nhà."
      ],
    ),
    Question(
      key: "9",
      text:
          "Bạn có sẵn sàng học nấu ăn nếu đối phương thích ăn đồ nhà làm không?",
      options: [
        "A. Có, tôi sẵn sàng học để chiều bạn trai/chồng.",
        "B. Chỉ nếu tôi thấy cần thiết.",
        "C. Không, tôi không thích nấu ăn."
      ],
    ),
    Question(
      key: "10",
      text: "Bạn có thích đi du lịch cùng người yêu/chồng không?",
      options: [
        "A. Có, tôi thích khám phá cùng nhau.",
        "B. Chỉ thỉnh thoảng, không quá thường xuyên.",
        "C. Không thích đi du lịch lắm."
      ],
    ),
    Question(
      key: "11",
      text:
          "Bạn có thích gặp gỡ và hòa hợp với gia đình, bạn bè của đối phương không?",
      options: [
        "A. Có, tôi muốn xây dựng mối quan hệ tốt với họ.",
        "B. Tùy từng người, không phải ai tôi cũng thân thiện.",
        "C. Không quan tâm lắm."
      ],
    ),
    Question(
      key: "12",
      text: "Bạn có sẵn sàng sinh con sớm sau khi kết hôn không?",
      options: [
        "A. Có, tôi thích có con ngay.",
        "B. Đợi vài năm rồi tính tiếp.",
        "C. Không muốn có con hoặc chưa nghĩ tới."
      ],
    ),
    Question(
      key: "13",
      text:
          "Bạn có sẵn sàng thay đổi thói quen cá nhân để phù hợp với đối phương không?",
      options: [
        "A. Có, tôi muốn thích nghi để hòa hợp.",
        "B. Chỉ trong giới hạn nhất định.",
        "C. Không, tôi muốn giữ thói quen của mình."
      ],
    ),
    Question(
      key: "14",
      text: "Bạn có thích chăm sóc chồng/bạn trai khi ốm đau không?",
      options: [
        "A. Có, tôi sẽ chăm sóc chu đáo.",
        "B. Vừa phải, nếu tôi có thời gian.",
        "C. Không, ai cũng phải tự lo cho bản thân."
      ],
    ),
    Question(
      key: "15",
      text: "Bạn có thích để bạn trai/chồng chủ động trong mọi việc không?",
      options: [
        "A. Có, tôi thích đàn ông mạnh mẽ, quyết đoán.",
        "B. Chỉ trong một số trường hợp quan trọng.",
        "C. Không, tôi muốn cùng nhau quyết định mọi thứ."
      ],
    ),
    Question(
      key: "16",
      text:
          "Bạn có sẵn sàng bỏ bớt các mối quan hệ nam giới khác nếu bạn trai/chồng không thích không?",
      options: [
        "A. Có, tôi ưu tiên mối quan hệ chính.",
        "B. Chỉ khi thấy họ thực sự không phù hợp.",
        "C. Không, tôi có quyền giữ bạn bè riêng."
      ],
    ),
    Question(
      key: "17",
      text: "Bạn có sẵn sàng ở nhà nội trợ nếu chồng kiếm đủ tiền không?",
      options: [
        "A. Có, tôi thích chăm sóc gia đình.",
        "B. Không chắc, tùy hoàn cảnh.",
        "C. Không, tôi muốn có sự nghiệp riêng."
      ],
    ),
    Question(
      key: "18",
      text: "Bạn có muốn chủ động trong chuyện chăn gối không?",
      options: [
        "A. Có, tôi thích sự chủ động và sáng tạo.",
        "B. Chỉ thỉnh thoảng, tùy cảm hứng.",
        "C. Không, tôi thích để đàn ông dẫn dắt."
      ],
    ),
    Question(
      key: "19",
      text: "Bạn có dễ dàng tha thứ nếu đối phương mắc lỗi nhỏ không?",
      options: [
        "A. Có, tôi không giữ bụng lâu.",
        "B. Tùy mức độ lỗi lầm.",
        "C. Không, tôi khó tha thứ."
      ],
    ),
    Question(
      key: "20",
      text:
          "Bạn có thích thử nghiệm những điều mới mẻ trong chuyện tình cảm không?",
      options: [
        "A. Có, tôi thích đổi mới để tránh nhàm chán.",
        "B. Chỉ một số thứ trong giới hạn chấp nhận được.",
        "C. Không, tôi thích sự quen thuộc và truyền thống."
      ],
    ),
  ];

  // ĐIỂM NAM - NỮ
  Map<int, Map<String, int>> diemTheoKeyNamNu = {
    1: {
      'A-A': 10,
      'A-B': 7,
      'A-C': 4,
      'B-A': 8,
      'B-B': 6,
      'B-C': 3,
      'C-A': 5,
      'C-B': 4,
      'C-C': 2
    },
    2: {
      'A-A': 10,
      'A-B': 7,
      'A-C': 3,
      'B-A': 8,
      'B-B': 6,
      'B-C': 2,
      'C-A': 5,
      'C-B': 4,
      'C-C': 1
    },
    3: {
      'A-A': 10,
      'A-B': 7,
      'A-C': 3,
      'B-A': 8,
      'B-B': 6,
      'B-C': 2,
      'C-A': 5,
      'C-B': 4,
      'C-C': 1
    },
    4: {
      'A-A': 10,
      'A-B': 8,
      'A-C': 5,
      'B-A': 7,
      'B-B': 6,
      'B-C': 4,
      'C-A': 5,
      'C-B': 4,
      'C-C': 2
    },
    5: {
      'A-A': 10,
      'A-B': 7,
      'A-C': 3,
      'B-A': 8,
      'B-B': 6,
      'B-C': 2,
      'C-A': 5,
      'C-B': 4,
      'C-C': 1
    },
    6: {
      'A-A': 10,
      'A-B': 8,
      'A-C': 4,
      'B-A': 7,
      'B-B': 6,
      'B-C': 3,
      'C-A': 5,
      'C-B': 4,
      'C-C': 2
    },
    7: {
      'A-A': 10,
      'A-B': 7,
      'A-C': 4,
      'B-A': 8,
      'B-B': 6,
      'B-C': 3,
      'C-A': 5,
      'C-B': 4,
      'C-C': 2
    },
    8: {
      'A-A': 10,
      'A-B': 8,
      'A-C': 5,
      'B-A': 7,
      'B-B': 6,
      'B-C': 4,
      'C-A': 5,
      'C-B': 4,
      'C-C': 2
    },
    9: {
      'A-A': 10,
      'A-B': 7,
      'A-C': 4,
      'B-A': 8,
      'B-B': 6,
      'B-C': 3,
      'C-A': 5,
      'C-B': 4,
      'C-C': 2
    },
    10: {
      'A-A': 10,
      'A-B': 8,
      'A-C': 5,
      'B-A': 7,
      'B-B': 6,
      'B-C': 4,
      'C-A': 5,
      'C-B': 4,
      'C-C': 2
    },
    11: {
      'A-A': 10,
      'A-B': 7,
      'A-C': 3,
      'B-A': 8,
      'B-B': 6,
      'B-C': 2,
      'C-A': 5,
      'C-B': 4,
      'C-C': 1
    }
  };
}
