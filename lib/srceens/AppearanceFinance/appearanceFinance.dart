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
import 'package:dropdown_button2/dropdown_button2.dart';

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

  final List<String> itemsInterest = [
    'Gầy',
    'Bình thường',
    'Đầy đặn',
    'Mập mạp',
  ];
  String? selectedValueInterest;

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
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Row(
                  children: [
                    Icon(
                      Icons.list,
                      size: 16,
                      color: AppColors.c_black,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.c_black_54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: itemsInterest
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.c_black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedValueInterest,
                onChanged: (String? value) {
                  setState(() {
                    selectedValueInterest = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  width: 160,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    // border: Border.all(
                    //   color: Colors.black26,
                    // ),
                    color: AppColors.c_blue_shade50,
                  ),
                  elevation: 2,
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: AppColors.c_black,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.c_blue_shade50,
                  ),
                  // offset: const Offset(-20, 0),
                  // scrollbarTheme: ScrollbarThemeData(
                  //   radius: const Radius.circular(40),
                  //   thickness: MaterialStateProperty.all<double>(6),
                  //   thumbVisibility: MaterialStateProperty.all<bool>(true),
                  // ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
