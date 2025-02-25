import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';

class MessageUser extends StatefulWidget {
  MessageUser({super.key, required this.message, required this.themeState});

  final String message;
  ThemeMode themeState;

  @override
  State<MessageUser> createState() => _MessageUserState();
}

class _MessageUserState extends State<MessageUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: widget.themeState == ThemeMode.dark
              ? AppColors.c_second_darkmode
              : AppColors.c_gray_255_217,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: SelectableText(
        widget.message,
        style: TextStyle(
          fontSize: AppSizeText.sizeText12,
          color: widget.themeState == ThemeMode.dark
              ? AppColors.backgroundColor
              : AppColors.c_black,
        ),
      ),
    );
  }
}
