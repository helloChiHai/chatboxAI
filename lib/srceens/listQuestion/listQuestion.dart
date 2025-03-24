import 'package:flutter/material.dart';
import 'package:stock_flutter/bloc/questions/questions_bloc.dart';
import 'package:stock_flutter/bloc/questions/questions_event.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/models/question_model.dart';
import 'package:stock_flutter/repositories/question_repository.dart';
import 'package:stock_flutter/services/QuestionService.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/header.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class ListQuestion extends StatefulWidget {
  final List<Question>? dataQuestion;
  final String titleHeader;
  final int sex;
  final String nameQuestion;

  const ListQuestion({
    super.key,
    this.dataQuestion,
    required this.titleHeader,
    required this.sex,
    required this.nameQuestion,
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
    if (widget.dataQuestion == null || widget.dataQuestion!.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Lỗi"),
          content: const Text("Không có câu hỏi nào để nộp."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    // Tìm câu hỏi chưa chọn
    int? firstUnansweredIndex;
    for (int i = 0; i < widget.dataQuestion!.length; i++) {
      if (widget.dataQuestion![i].selectedOption == null) {
        firstUnansweredIndex = i;
        break;
      }
    }

    if (firstUnansweredIndex != null) {
      // Cuộn tới câu hỏi chưa chọn
      _scrollController.animateTo(
        firstUnansweredIndex * 120.0, // Ước lượng chiều cao của mỗi item
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Lỗi"),
          content: Text(
              "Vui lòng chọn câu trả lời cho câu ${firstUnansweredIndex! + 1}."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );

      return;
    }

    // Lưu câu trả lời
    questionsBloc.add(SaveQuestionsEvent(
      questions: widget.dataQuestion!.map((q) {
        return {
          "key": q.key,
          "selectedOption": q.selectedOption ?? "Chưa chọn"
        };
      }).toList(),
      key: widget.nameQuestion,
    ));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Text("Kết quả đã lưu ${widget.nameQuestion}"),
        title: const Text("Kết quả đã lưu"),
        content: const Text("Câu trả lời đã được lưu thành công."),
        actions: [
          TextButton(
            onPressed: () => Utils.navigatorGoBack(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void handleGoBack(BuildContext context) {
    // xoá dữ liệu trước khi back ra
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
            const EdgeInsets.only(right: 10, left: 10, top: 40, bottom: 25),
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
            InkWell(
              onTap: submitAnswers,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.c_blue,
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
            )
          ],
        ),
      ),
    );
  }
}
