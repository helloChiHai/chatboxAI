import 'package:flutter/material.dart';
import 'package:stock_flutter/bloc/appearanceFinanceBloc/appearanceFinance_bloc.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/constants/mock_data.dart';
import 'package:stock_flutter/models/question_model.dart';
import 'package:stock_flutter/models/userInformation_model.dart';
import 'package:stock_flutter/repositories/appearanceFinance_repository.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/services/appearanceFinanceService.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

// ignore: must_be_immutable
class AppearanceFinance extends StatefulWidget {
  String titleHeader;
  String sex;
  AppearanceFinance({super.key, required this.titleHeader, required this.sex});

  @override
  State<AppearanceFinance> createState() => _AppearanceFinanceState();
}

class _AppearanceFinanceState extends State<AppearanceFinance> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  late AppearanceFinanceBloc appearanceFinanceBloc;

  @override
  void initState() {
    super.initState();
    appearanceFinanceBloc = AppearanceFinanceBloc(
        repository: AppearanceFinanceRepository(
            appearanceFinanceService: AppearanceFinanceService()));
  }

  void handleGoListQuestion({
    required int sex,
    required String titleHeader,
    required List<Question> data,
    required UserInformationModel dataUserInformation,
  }) {
    Utils.navigator(
      context,
      AppRoutes.listQuestion,
      arguments: {
        'sex': sex,
        'titleHeader': titleHeader,
        'dataQuestion': data,
        'dataUserInformation': dataUserInformation
      },
    );
  }

  void submitData(BuildContext context) {
    String height = heightController.text;
    String weight = weightController.text;
    String income = incomeController.text;
    String age = ageController.text;

    if (height.isEmpty || weight.isEmpty || income.isEmpty || age.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin!")),
      );
      return;
    }

    List<Map<String, dynamic>> questions = [
      {"label": "Chiều cao", "value": height, "unit": "cm"},
      {"label": "Cân nặng", "value": weight, "unit": "kg"},
      // {"label": "Vóc dáng", "value": selectedValueInterest, "unit": "vocDang"},
      {"label": "Thu nhập", "value": income, "unit": "VND"},
      {"label": "Độ tuổi", "value": age, "unit": "tuổi"},
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Text("Thông tin cá nhân của ${widget.sex == "1" ? 'nam' : 'nữ'}"),
          content: Text(
              "Chiều cao: $height cm\nCân nặng: $weight kg\nThu nhập: $income VND\nĐộ tuổi: $age tuổi"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Utils.navigatorGoBack(context);
                handleGoListQuestion(
                  sex: widget.sex == "1" ? 1 : 0,
                  titleHeader:
                      'Nhu cầu của ${widget.sex == "1" ? 'nam' : 'nữ'}',
                  data: widget.sex == "1"
                      ? MockData.dataNhuCauNam
                      : MockData.dataNhuCauNu,
                  dataUserInformation: UserInformationModel(
                      height: height, weight: weight, income: income, age: age),
                );
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  final List<String> itemsInterest = [
    'Gầy',
    'Bình thường',
    'Đầy đặn',
    'Mập mạp',
  ];
  String? selectedValueInterest;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 40, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField(
                "Chiều cao (cm)", heightController, TextInputType.number),
            buildTextField(
                "Cân nặng (kg)", weightController, TextInputType.number),
            buildTextField("Thu nhập hàng tháng (VND)", incomeController,
                TextInputType.number),
            buildTextField("Độ tuổi", ageController, TextInputType.number),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => submitData(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.c_blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: textCus(
                  context: context,
                  text: 'Xác nhận',
                  color: AppColors.c_white,
                  fontWeight: FontWeight.bold,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, TextEditingController controller, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: type,
        style: const TextStyle(fontSize: AppSizeText.sizeText12),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.blue.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}
