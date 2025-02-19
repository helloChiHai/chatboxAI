import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

Widget btnCusLogin({
  required BuildContext context,
  required String title,
  Color bgColor = const Color(0xFF3F9FED),
  Color colorTile = AppColors.backgroundColor,
  VoidCallback? pressBtn,
}) {
  return GestureDetector(
    onTap: pressBtn,
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: bgColor,
      ),
      child: textCus(
          context: context,
          text: title,
          fontWeight: FontWeight.w600,
          color: colorTile,
          fontSize: AppSizeText.sizeText14,
          textAlign: TextAlign.center),
    ),
  );
}
