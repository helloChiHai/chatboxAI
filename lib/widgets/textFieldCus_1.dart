import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

Widget textFieldCus_1({
  required BuildContext context,
  required TextEditingController controller,
  required String title,
  String? hintText,
  bool showIcon = false,
  IconData? iconOn,
  IconData? iconOff,
  VoidCallback? voidCallback,
  String txtError = '',
  FocusNode? focusNode,
  bool isAutofocus = false,
  bool onOffIcon = false,
}) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textCus(context: context, text: title),
        const SizedBox(height: 5),
        TextField(
          autofocus: isAutofocus,
          obscureText: onOffIcon,
          focusNode: focusNode,
          style: const TextStyle(
              fontSize: AppSizeText.sizeText12, color: AppColors.c_black),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: AppSizeText.sizeText12,
            ),
            suffixIcon: showIcon
                ? IconButton(
                    onPressed: voidCallback,
                    icon: Icon(
                      onOffIcon ? iconOff : iconOn,
                    ),
                  )
                : null,
            filled: true,
            fillColor: AppColors.c_white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: const Color.fromARGB(255, 13, 151, 220),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color:
                    txtError.isEmpty ? AppColors.c_3399FF : AppColors.c_FF0033,
                width: 1.5,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
          ),
        ),
        const SizedBox(height: 5),
        txtError.isNotEmpty
            ? textCus(
                context: context,
                text: txtError,
                color: AppColors.c_FF0033,
                fontSize: AppSizeText.sizeText11)
            : SizedBox(),
      ],
    ),
  );
}
