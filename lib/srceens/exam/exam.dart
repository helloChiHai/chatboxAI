import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/constants/mock_data.dart';
import 'package:stock_flutter/models/question_model.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/srceens/exam/widget/selectedSex.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class Exam extends StatefulWidget {
  const Exam({super.key});

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  int sex = 1; // 1: nam; 0; nu

  void handleGoListQuestion(
    int sex,
    String titleHeader,
    List<Question> data,
    String nameQuestion,
  ) {
    Utils.navigator(
      context,
      AppRoutes.listQuestion,
      arguments: {
        'sex': sex,
        'titleHeader': titleHeader,
        'dataQuestion': data,
        'nameQuestion': nameQuestion
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // select set
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SelectedSex(
                    pressSelectSex: () {
                      setState(() {
                        sex = 1;
                      });
                    },
                    title: 'Nam',
                    sex: 1,
                    selectSex: sex,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: SelectedSex(
                    pressSelectSex: () {
                      setState(() {
                        sex = 0;
                      });
                    },
                    title: 'Nữ',
                    sex: 0,
                    selectSex: sex,
                  ),
                ),
              ],
            ),
          ),
          // list question
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => handleGoListQuestion(
                      sex == 1 ? 1 : 0,
                      'Nhu cầu của ${sex == 1 ? 'nam' : 'nữ'}',
                      MockData.questions,
                      "nhuCau${sex == 1 ? 'Nam' : 'Nu'}",
                    ),
                    child: SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textCus(
                            context: context,
                            text: 'Nhu cầu của ${sex == 1 ? 'nam' : 'nữ'}',
                            fontSize: AppSizeText.sizeText14,
                          ),
                          const Icon(
                            Icons.arrow_right,
                            size: 20,
                            color: AppColors.c_black,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => handleGoListQuestion(
                      sex == 1 ? 1 : 0,
                      'Khả năng của ${sex == 1 ? 'nam' : 'nữ'}',
                      MockData.questions,
                      "khaNang${sex == 1 ? 'Nam' : 'Nu'}",
                    ),
                    child: SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textCus(
                            context: context,
                            text:
                                'Khả năng đáp ứng của ${sex == 1 ? 'nam' : 'nữ'}',
                            fontSize: AppSizeText.sizeText14,
                          ),
                          const Icon(
                            Icons.arrow_right,
                            size: 20,
                            color: AppColors.c_black,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
