import 'package:flutter/material.dart';
import 'package:stock_flutter/bloc/appearanceFinanceBloc/appearanceFinance_bloc.dart';
import 'package:stock_flutter/bloc/appearanceFinanceBloc/appearanceFinance_event.dart';
import 'package:stock_flutter/bloc/appearanceFinanceBloc/appearanceFinance_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/repositories/appearanceFinance_repository.dart';
import 'package:stock_flutter/services/appearanceFinanceService.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/header.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

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

  void submitData(BuildContext context) {
    String height = heightController.text;
    String weight = weightController.text;
    String income = incomeController.text;
    String age = ageController.text;

    // Kiểm tra dữ liệu có hợp lệ không
    if (height.isEmpty || weight.isEmpty || income.isEmpty || age.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin!")),
      );
      return;
    }

    // Tạo danh sách câu hỏi dưới dạng Map<String, dynamic>
    List<Map<String, dynamic>> questions = [
      {"label": "Chiều cao", "value": height, "unit": "cm"},
      {"label": "Cân nặng", "value": weight, "unit": "kg"},
      {"label": "Thu nhập", "value": income, "unit": "VND"},
      {"label": "Độ tuổi", "value": age, "unit": "tuổi"},
    ];

    // Xác định key lưu trữ
    String key =
        widget.sex == "1" ? 'ngoaiHinhTaiChinhNam' : 'ngoaiHinhTaiChinhNu';

    // Gửi sự kiện lưu dữ liệu
    appearanceFinanceBloc.add(SaveAppearanceFinanceEvent(
      key: key,
      questions: questions,
    ));

    print('key: $key - questions: $questions');

    // Hiển thị Dialog xác nhận trước, khi nhấn OK thì mới quay về màn trước
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Thông tin cá nhân"),
          content: Text(
              "Chiều cao: $height cm\nCân nặng: $weight kg\nThu nhập: $income VND\nĐộ tuổi: $age tuổi"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng dialog
                Utils.navigatorGoBack(
                    context); // Quay lại màn trước sau khi đóng dialog
              },
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }

  // void submitData(BuildContext context) {
  //   String height = heightController.text;
  //   String weight = weightController.text;
  //   String income = incomeController.text;
  //   String age = ageController.text;

  //   // Tạo danh sách câu hỏi dưới dạng Map<String, dynamic>
  //   List<Map<String, dynamic>> questions = [
  //     {"label": "Chiều cao", "value": height, "unit": "cm"},
  //     {"label": "Cân nặng", "value": weight, "unit": "kg"},
  //     {"label": "Thu nhập", "value": income, "unit": "VND"},
  //     {"label": "Độ tuổi", "value": age, "unit": "tuổi"},
  //   ];

  //   // Gửi sự kiện lưu dữ liệu
  //   appearanceFinanceBloc.add(SaveAppearanceFinanceEvent(
  //     key: widget.sex == '1' ? 'ngoaiHinhTaiChinhNam' : 'ngoaiHinhTaiChinhNu',
  //     questions: questions,
  //   ));

  //   print('questions: $questions');

  //   // Hiển thị Dialog xác nhận
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Thông tin cá nhân"),
  //         content: Text(
  //             "Chiều cao: $height cm\nCân nặng: $weight kg\nThu nhập: $income VND\nĐộ tuổi: $age tuổi"),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text("OK"),
  //           )
  //         ],
  //       );
  //     },
  //   );

  //   // trả về màn trước
  //   Utils.navigatorGoBack(context);
  // }

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
