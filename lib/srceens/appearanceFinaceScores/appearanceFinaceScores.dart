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
              title: 'Kết quả ngoại hình và tài chính',
              showIconRight: false,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child:
                    BlocBuilder<AppearanceFinanceBloc, AppearanceFinanceState>(
                  builder: (context, state) {
                    if (state is AppearanceFinanceLoaded) {
                      List<int> valuesNu =
                          (state.questionsMap['ngoaiHinhTaiChinhNu'] ?? [])
                              .map((e) {
                        var valueNu = e["value"];
                        return valueNu is int
                            ? valueNu
                            : int.tryParse(valueNu.toString()) ?? 0;
                      }).toList();

                      int chieuCaoNu = valuesNu[0];
                      int canNangNu = valuesNu[1];
                      int thuNhapNu = valuesNu[2];
                      int doTuoiNu = valuesNu[3];

                      List<int> valuesNam =
                          (state.questionsMap['ngoaiHinhTaiChinhNam'] ?? [])
                              .map((e) {
                        var valueNam = e["value"];
                        return valueNam is int
                            ? valueNam
                            : int.tryParse(valueNam.toString()) ?? 0;
                      }).toList();

                      int chieuCaoNam = valuesNam[0];
                      int canNangNam = valuesNam[1];
                      int thuNhapNam = valuesNam[2];
                      int doTuoiNam = valuesNam[3];

                      String ketQua = Utils.tinhTongDiem(
                        chieuCaoNam: chieuCaoNam,
                        chieuCaoNu: chieuCaoNu,
                        canNangNam: canNangNam,
                        soThichNu: 'gầy',
                        thuNhapNam: double.parse(thuNhapNam.toString()),
                        thuNhapNu: double.parse(thuNhapNu.toString()),
                        tuoiNam: doTuoiNam,
                        tuoiNu: doTuoiNu,
                      );

                      return Column(
                        children: [
                          // _buildScoreSection('Nhu cầu', ngoaiHinhNam),
                          const SizedBox(height: 20),
                          // _buildScoreSection('Khả năng đáp ứng', ngoaiHinhNu),
                          const SizedBox(height: 20),
                          Text(
                            'Kết quả: $ketQua',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
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

  Widget _buildScoreSection(String title, Map<String, dynamic> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...questions.entries
            .map((entry) => Text('${entry.key}: ${entry.value}'))
            .toList(),
      ],
    );
  }
}
