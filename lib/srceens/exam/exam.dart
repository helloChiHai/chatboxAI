import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/constants/mock_data.dart';
import 'package:stock_flutter/models/question_model.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/srceens/AppearanceFinance/appearanceFinance.dart';
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

  void handleGoResultMenAndWomen(
    String titleHeader,
    int typeScores,
  ) {
    Utils.navigator(
      context,
      AppRoutes.miniTestScores,
      arguments: {
        'titleHeader': titleHeader,
        'typeScores': typeScores, // 1: nam-nu; 2:nu-nam
      },
    );
  }

  void handleGoResultAppearanceFinance() {
    Utils.navigator(
      context,
      AppRoutes.appearanceFinaceScores,
      arguments: {},
    );
  }

  void handleGoAppearanceFinance(String titleHeader, String sex) {
    Utils.navigator(
      context,
      AppRoutes.appearanceFinance,
      arguments: {
        'titleHeader': titleHeader,
        'sex': sex, // 1: nam; 0:nu
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            child: AppearanceFinance(
              sex: sex == 1 ? "1" : "2",
              titleHeader: sex == 1 ? 'nam' : 'nữ',
            ),
          ),
        ],
      ),
    );
  }
}
