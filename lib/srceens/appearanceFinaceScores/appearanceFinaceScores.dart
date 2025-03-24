//
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/appearanceFinanceBloc/appearanceFinance_bloc.dart';
import 'package:stock_flutter/bloc/appearanceFinanceBloc/appearanceFinance_event.dart';
import 'package:stock_flutter/bloc/appearanceFinanceBloc/appearanceFinance_state.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/header.dart';

class AppearanceFinaceScores extends StatefulWidget {
  AppearanceFinaceScores({
    super.key,
  });

  @override
  State<AppearanceFinaceScores> createState() => _MiniTestScoresState();
}

class _MiniTestScoresState extends State<AppearanceFinaceScores> {
  @override
  void initState() {
    super.initState();

    context
        .read<AppearanceFinanceBloc>()
        .add(LoadAppearanceFinanceEvent(key: 'ngoaiHinhTaiChinhNam'));
    context
        .read<AppearanceFinanceBloc>()
        .add(LoadAppearanceFinanceEvent(key: 'ngoaiHinhTaiChinhNu'));
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
              title: ' widget.titleHeader',
              showIconRight: false,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child:
                    BlocBuilder<AppearanceFinanceBloc, AppearanceFinanceState>(
                  builder: (context, state) {
                    if (state is AppearanceFinanceLoaded) {
                      final nhuCauList =
                          state.questionsMap['ngoaiHinhTaiChinhNam'] ?? [];
                      final khaNangList =
                          state.questionsMap['ngoaiHinhTaiChinhNu'] ?? [];

                      if (nhuCauList.isNotEmpty && khaNangList.isNotEmpty) {
                        // int diemPhuHop = Utils.tinhDiemPhuHop(
                        //     nhuCauList, khaNangList, MockData.diemTheoKeyNamNu);

                        return Column(
                          children: [
                            _buildScoreSection('Nhu cầu', nhuCauList),
                            const SizedBox(height: 20),
                            _buildScoreSection('Khả năng đáp ứng', khaNangList),
                            const SizedBox(height: 20),
                            Text(
                              'Điểm: 10',
                              style: const TextStyle(
                                fontSize: AppSizeText.sizeText17,
                                fontWeight: FontWeight.bold,
                              ),
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
