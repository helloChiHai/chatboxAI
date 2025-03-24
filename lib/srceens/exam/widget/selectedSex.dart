import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class SelectedSex extends StatefulWidget {
  VoidCallback pressSelectSex;
  String title;
  int sex;
  int selectSex; // 1: nam; 0: nu
  SelectedSex({
    super.key,
    required this.pressSelectSex,
    required this.title,
    required this.sex,
    required this.selectSex,
  });

  @override
  State<SelectedSex> createState() => _SelectedSexState();
}

class _SelectedSexState extends State<SelectedSex> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.pressSelectSex,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: widget.sex == widget.selectSex
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.c_blue,
                    width: 2,
                  ),
                ),
              )
            : null,
        child: textCus(
            context: context,
            text: widget.title,
            fontSize: AppSizeText.sizeText14,
            fontWeight: widget.sex == widget.selectSex
                ? FontWeight.bold
                : FontWeight.normal,
            color: AppColors.c_black),
      ),
    );
  }
}
