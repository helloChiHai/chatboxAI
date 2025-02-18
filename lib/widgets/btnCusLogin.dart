import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

Widget btnCusLogin({
  required BuildContext context,
  required String title,
  Color colorTop = const Color(0xFF004AAD),
  Color colorBottom = const Color(0xFF3F9FED),
  Color colorTile = AppColors.backgroundColor,
  VoidCallback? pressBtn,
}) {
  return GestureDetector(
    onTap: pressBtn,
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colorTop, colorBottom],
        ),
      ),
      child: textCus(
          context: context,
          text: title,
          fontWeight: FontWeight.w600,
          color: colorTile,
          fontSize: AppSizeText.sizeText14),
    ),
  );
}
