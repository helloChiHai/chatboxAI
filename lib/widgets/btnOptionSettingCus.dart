import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class BtnOptionSettingCus extends StatelessWidget {
  VoidCallback fnPress;
  String title;
  IconData icon;

  BtnOptionSettingCus({
    super.key,
    required this.fnPress,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fnPress,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.c_black,
            size: 20,
          ),
          const SizedBox(width: 10),
          textCus(
            context: context,
            text: title,
            fontWeight: FontWeight.w500,
            fontSize: AppSizeText.sizeText14,
            color: AppColors.c_black,
          ),
        ],
      ),
    );
  }
}
