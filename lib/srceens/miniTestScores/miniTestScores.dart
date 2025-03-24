import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/questions/questions_bloc.dart';
import 'package:stock_flutter/bloc/questions/questions_event.dart';
import 'package:stock_flutter/bloc/questions/questions_state.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/constants/mock_data.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/header.dart';

class MiniTestScores extends StatefulWidget {
  String titleHeader;
  int typeScores;
  MiniTestScores({
    super.key,
    required this.titleHeader,
    required this.typeScores, //1: nam-nu; 2: nu-nam
  });

  @override
  State<MiniTestScores> createState() => _MiniTestScoresState();
}

class _MiniTestScoresState extends State<MiniTestScores> {
  String key1 = '';
  String key2 = '';

  @override
  void initState() {
    super.initState();
    if (widget.typeScores == 1) {
      key1 = 'nhuCauNam';
      key2 = 'khaNangNu';
    } else if (widget.typeScores == 2) {
      key1 = 'nhuCauNu';
      key2 = 'khaNangNam';
    }

    context.read<QuestionsBloc>().add(LoadQuestionEvent(key: key1));
    context.read<QuestionsBloc>().add(LoadQuestionEvent(key: key2));
  }

  String getSuitabilityText(int score) {
    if (score >= 160) {
      return "Cực kỳ phù hợp, tỷ lệ thành công cao.";
    } else if (score >= 120) {
      return "Khá phù hợp, có thể phát triển thêm.";
    } else if (score >= 80) {
      return "Cần điều chỉnh và thỏa hiệp.";
    } else {
      return "Không hợp, cần cân nhắc kỹ.";
    }
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
              fnLeftPress: () {
                Utils.navigatorGoBack(context);
              },
              fnRightPress: () {},
              iconData: Icons.arrow_back_ios,
              title: widget.titleHeader,
              showIconRight: false,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<QuestionsBloc, QuestionsState>(
                  builder: (context, state) {
                    if (state is QuestionLoaded) {
                      final nhuCauList = state.questionsMap[key1] ?? [];
                      final khaNangList = state.questionsMap[key2] ?? [];

                      if (nhuCauList.isNotEmpty && khaNangList.isNotEmpty) {
                        int diemPhuHop = Utils.tinhDiemPhuHop(
                            nhuCauList, khaNangList, MockData.diemTheoKeyNamNu);

                        return Column(
                          children: [
                            // Text('$key1 - $key2'),
                            // _buildScoreSection('Nhu cầu', nhuCauList),
                            // const SizedBox(height: 20),
                            // _buildScoreSection('Khả năng đáp ứng', khaNangList),
                            // const SizedBox(height: 20),
                            Text('Điểm: ${diemPhuHop.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    fontSize: AppSizeText.sizeText17,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              'Mức độ phù hợp: ${getSuitabilityText(diemPhuHop)}',
                              style: const TextStyle(
                                fontSize: AppSizeText.sizeText17,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      }
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreSection(String title, List<dynamic> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...questions.map((q) => Text(q.toString())).toList(),
      ],
    );
  }
}
