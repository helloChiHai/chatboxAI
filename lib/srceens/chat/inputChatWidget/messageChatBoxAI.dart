import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class MessageChatBoxAI extends StatefulWidget {
  MessageChatBoxAI({super.key, required this.message});

  final String message;
  // ThemeMode themeState;

  @override
  State<MessageChatBoxAI> createState() => _MessageChatBoxAIState();
}

class _MessageChatBoxAIState extends State<MessageChatBoxAI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
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
              SizedBox(width: 5),
              textCus(context: context, text: 'pleaseWaitAMoment')
            ],
          ),
          SizedBox(height: 10),
          // SelectableText(
          //   widget.message,
          //   style: TextStyle(
          //       fontSize: AppSizeText.sizeText12, color: AppColors.c_black
          //       // color: widget.themeState == ThemeMode.dark
          //       //     ? AppColors.backgroundColor
          //       //     : AppColors.c_black,
          //       ),
          // ),
          AnimatedTextKit(animatedTexts: [
            TyperAnimatedText(widget.message),
          ])
        ],
      ),
    );
  }
}
