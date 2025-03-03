// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/constants/localization.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class ChatWelcomeWidget extends StatefulWidget {
  const ChatWelcomeWidget({
    super.key,
  });

  @override
  State<ChatWelcomeWidget> createState() => _ChatWelcomeWidgetState();
}

class _ChatWelcomeWidgetState extends State<ChatWelcomeWidget> {
  final TextEditingController inputController = TextEditingController();
  bool showIconFullTextField = false;
  int maxLines = 6;
  double borderRadius = 30;
  bool showFullInputChat = false;

  @override
  void initState() {
    super.initState();
    inputController.addListener(getTextLineCount);
  }

  @override
  void dispose() {
    inputController.removeListener(getTextLineCount);
    inputController.dispose();
    super.dispose();
  }

  void getTextLineCount() {
    final span = TextSpan(
      text: inputController.text,
      style: const TextStyle(fontSize: AppSizeText.sizeText12),
    );
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: MediaQuery.of(context).size.width - 32);

    final numLines = tp.computeLineMetrics().length;

    setState(() {
      showIconFullTextField = numLines >= 4;

      borderRadius = numLines >= 2 ? 20 : 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            showFullInputChat
                ? const SizedBox(height: 10)
                : ShaderMask(
                    shaderCallback: (bounds) {
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
                    child: textCus(
                      context: context,
                      text: 'Xin chào Vương Chí Hải!',
                      fontSize: AppSizeText.sizeText30,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      color: AppColors.c_white,
                    ),
                  ),
            Expanded(
              flex: showFullInputChat ? 1 : 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.c_gray,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius)),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Đảm bảo chiều cao bằng nhau
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: TextField(
                            controller: inputController,
                            minLines: 1,
                            maxLines: maxLines,
                            cursorColor: AppColors.c_blue,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: AppSizeText.sizeText12),
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)
                                  .translate('askChatBotAI'),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                left: 15,
                                top: 10,
                                bottom: 10,
                              ),
                              hintStyle: const TextStyle(
                                fontSize: AppSizeText.sizeText12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: showIconFullTextField
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.end,
                          children: [
                            if (showIconFullTextField)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showFullInputChat = !showFullInputChat;
                                  });
                                },
                                child: Icon(
                                  showFullInputChat
                                      ? Icons.zoom_in_map_outlined
                                      : Icons.zoom_out_map,
                                ),
                              ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 223, 230, 230),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.send,
                                  size: 20,
                                  color: AppColors.c_darkmode,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
