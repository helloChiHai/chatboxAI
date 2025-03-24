import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/questions/questions_bloc.dart';
import 'package:stock_flutter/bloc/questions/questions_event.dart';
import 'package:stock_flutter/bloc/questions/questions_state.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
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
  String key1 = 'nhuCauNam';
  String key2 = 'khaNangNu';

  @override
  void initState() {
    super.initState();
    if (widget.typeScores == 1) {
      key1 = 'nhuCauNam';
      key2 = 'khaNangNu';
    }

    // Load dữ liệu từ 2 key
    context.read<QuestionsBloc>().add(LoadQuestionEvent(key: key1));
    context.read<QuestionsBloc>().add(LoadQuestionEvent(key: key2));
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
        child: SingleChildScrollView(
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
              BlocBuilder<QuestionsBloc, QuestionsState>(
                builder: (context, state) {
                  if (state is QuestionLoaded) {
                    final nhuCauList = state.questionsMap[key1] ?? [];
                    return _buildScoreSection('Nhu cầu', nhuCauList);
                  }
                  return const CircularProgressIndicator();
                },
              ),
              BlocBuilder<QuestionsBloc, QuestionsState>(
                builder: (context, state) {
                  if (state is QuestionLoaded) {
                    final khaNangList = state.questionsMap[key2] ?? [];
                    return _buildScoreSection('Khả năng đáp ứng', khaNangList);
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
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
