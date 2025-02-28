import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';

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
      margin: EdgeInsets.only(bottom: 20),
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
              // SizedBox(width: 5),
              // widget.checkLoad
              //     ? textCus(context: context, text: 'pleaseWaitAMoment')
              // : textCus(context: context, text: 'khong cho')
            ],
          ),
          SizedBox(height: 10),
          AnimatedTextKit(
            totalRepeatCount: 1,
            animatedTexts: [
              TyperAnimatedText(widget.message),
            ],
          )
        ],
      ),
    );
  }
}
