import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stock_flutter/bloc/questions/questions_bloc.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/models/question_model.dart';
import 'package:stock_flutter/models/result_model.dart';
import 'package:stock_flutter/models/userInformation_model.dart';
import 'package:stock_flutter/repositories/question_repository.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/services/QuestionService.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/header.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class ListQuestion extends StatefulWidget {
  final List<Question>? dataQuestion;
  final String titleHeader;
  final int sex;
  final UserInformationModel dataUserInformation;

  const ListQuestion({
    super.key,
    this.dataQuestion,
    required this.titleHeader,
    required this.sex,
    required this.dataUserInformation,
  });

  @override
  State<ListQuestion> createState() => _ListQuestionState();
}

class _ListQuestionState extends State<ListQuestion> {
  late QuestionsBloc questionsBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    questionsBloc = QuestionsBloc(
        repository: QuestionRepository(questionService: QuestionService()));
  }

  void submitAnswers() {
    // if (widget.dataQuestion == null || widget.dataQuestion!.isEmpty) {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: const Text("Lỗi"),
    //       content: const Text("Không có câu hỏi nào để nộp."),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.pop(context),
    //           child: const Text("OK"),
    //         ),
    //       ],
    //     ),
    //   );
    //   return;
    // }

    // Tìm câu hỏi chưa chọn
    // int? firstUnansweredIndex;
    // for (int i = 0; i < widget.dataQuestion!.length; i++) {
    //   if (widget.dataQuestion![i].selectedOption == null) {
    //     firstUnansweredIndex = i;
    //     break;
    //   }
    // }

    // if (firstUnansweredIndex != null) {
    //   // Cuộn tới câu hỏi chưa chọn
    //   _scrollController.animateTo(
    //     firstUnansweredIndex * 120.0, // Ước lượng chiều cao của mỗi item
    //     duration: const Duration(milliseconds: 500),
    //     curve: Curves.easeInOut,
    //   );

    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: const Text("Lỗi"),
    //       content: Text(
    //           "Vui lòng chọn câu trả lời cho câu ${firstUnansweredIndex! + 1}."),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.pop(context),
    //           child: const Text("OK"),
    //         ),
    //       ],
    //     ),
    //   );

    //   return;
    // }

    var result = ResultModel(
      key: widget.sex == 1 ? 'Nam' : 'Nu',
      informationUser: widget.dataUserInformation,
      listQuestion: widget.dataQuestion!,
    );

    String jsonData = jsonEncode(result.toJson());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Text("Kết quả đã lưu ${widget.nameQuestion}"),
        title: const Text("Kết quả đã được tạo"),
        content: const Text("Câu trả lời đã được lưu thành công."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              handleGoListQuestion(jsonData: jsonData);
            },
            child: const Text("Xem QR Code kết quả"),
          ),
        ],
      ),
    );
  }

  bool isAllQuestionsAnswered() {
    if (widget.dataQuestion == null || widget.dataQuestion!.isEmpty) {
      return false;
    }
    return widget.dataQuestion!.every((q) => q.selectedOption != null);
  }

  void handleGoListQuestion({
    required String jsonData,
  }) {
    Utils.navigator(
      context,
      AppRoutes.resultQrCode,
      arguments: {
        'jsonData': jsonData,
      },
    );
  }

  void handleGoBack(BuildContext context) {
    if (widget.dataQuestion != null) {
      for (var question in widget.dataQuestion!) {
        question.selectedOption = null;
      }
    }

    Utils.navigatorGoBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 40, bottom: 10),
        child: Column(
          children: [
            HeaderCus(
              fnLeftPress: () => handleGoBack(context),
              fnRightPress: () {},
              iconData: Icons.arrow_back_ios,
              title: widget.titleHeader,
              showIconRight: false,
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(10),
                itemCount: widget.dataQuestion!.length,
                itemBuilder: (context, index) {
                  var question = widget.dataQuestion![index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${question.key}. ${question.text}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          ...question.options.map((option) {
                            return RadioListTile<String>(
                              title: Text(
                                option,
                                style: const TextStyle(fontSize: 12),
                              ),
                              value: option.split('. ')[0],
                              groupValue: question.selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  question.selectedOption = value;
                                });
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: isAllQuestionsAnswered() ? submitAnswers : null,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isAllQuestionsAnswered()
                        ? AppColors.c_blue
                        : Colors.grey[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: textCus(
                    context: context,
                    text: 'Nộp bài',
                    fontSize: AppSizeText.sizeText14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.c_white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
