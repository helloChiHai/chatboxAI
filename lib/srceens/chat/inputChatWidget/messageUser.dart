import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class MessageUser extends StatefulWidget {
  MessageUser({
    super.key,
    required this.message,
    required this.index,
    required this.count,
    required this.isLoad,
  });

  final int index;
  final int count;
  final bool isLoad;
  final String message;
  // ThemeMode themeState;

  @override
  State<MessageUser> createState() => _MessageUserState();
}

class _MessageUserState extends State<MessageUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
                color: AppColors.c_gray_255_217,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: SelectableText(
              widget.message,
              style: const TextStyle(
                  fontSize: AppSizeText.sizeText12, color: AppColors.c_black),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      AppColors.c_blue,
                      AppColors.c_purple,
                      AppColors.c_pink,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn, // Giữ lại phần trong của ảnh
                child: Image.asset(
                  'assets/imgs/sparkling.png',
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(width: 5),
              widget.count == widget.index
                  ? widget.isLoad
                      ? textCus(context: context, text: 'pleaseWaitAMoment')
                      : textCus(context: context, text: '')
                  : const SizedBox()
            ],
          ),
        )
      ],
    );
  }
}
