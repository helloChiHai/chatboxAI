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
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => handleGoAppearanceFinance(
                      'Ngoài hình và tài chính của ${sex == 1 ? 'nam' : 'nữ'}',
                      sex == 1 ? '1' : '0',
                    ),
                    child: SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textCus(
                            context: context,
                            text:
                                'Ngoài hình và tài chính của ${sex == 1 ? 'nam' : 'nữ'}',
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
                    onTap: handleGoResultAppearanceFinance,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: AppColors.c_3399FF,
                          width: 1,
                        ))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            textCus(
                              context: context,
                              text: 'Kết quả của ngoài hình tài chính',
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
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => handleGoListQuestion(
                      sex == 1 ? 1 : 0,
                      'Nhu cầu của ${sex == 1 ? 'nam' : 'nữ'}',
                      sex == 1 ? MockData.dataNhuCauNam : MockData.dataNhuCauNu,
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
                      sex == 1
                          ? MockData.dataKhaNangCuaNam
                          : MockData.dataKhaNangCuaNu,
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
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => handleGoResultMenAndWomen(
                        'Kết quả của ${sex == 1 ? 'Nam - Nữ' : 'Nữ - Nam'}',
                        sex == 1 ? 1 : 2), // 1: nam-nu; 2: nu-nam
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: AppColors.c_3399FF,
                          width: 1,
                        ))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            textCus(
                              context: context,
                              text:
                                  'Kết quả của ${sex == 1 ? 'nam - nữ' : 'nữ - nam'}',
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
