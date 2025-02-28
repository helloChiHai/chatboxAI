import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/constants/localization.dart';

class InputCus extends StatefulWidget {
  VoidCallback pressSendMessage;
  TextEditingController inputController;
  bool isAutofocus;
  FocusNode? focusNode;

  InputCus({
    super.key,
    required this.pressSendMessage,
    required this.inputController,
    this.focusNode,
    this.isAutofocus = false,
  });

  @override
  State<InputCus> createState() => _InputCusState();
}

class _InputCusState extends State<InputCus> {
  bool showFullInputChat = false;
  double borderRadius = 30;
  int maxLines = 6;
  bool showIconFullTextField = false;

  @override
  void initState() {
    super.initState();
    widget.inputController.addListener(getTextLineCount);
  }

  void getTextLineCount() {
    final span = TextSpan(
      text: widget.inputController.text,
      style: TextStyle(fontSize: AppSizeText.sizeText12),
    );
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: MediaQuery.of(context).size.width - 32);

    final numLines = tp.computeLineMetrics().length;

    if (mounted) {
      setState(() {
        showIconFullTextField = numLines >= 2;

        borderRadius = numLines >= 2 ? 20 : 30;
      });
    }
  }

  @override
  void dispose() {
    widget.inputController.removeListener(getTextLineCount);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: showFullInputChat && widget.inputController.text.isNotEmpty ? 1 : 0,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.c_gray,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(borderRadius)),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Đảm bảo chiều cao bằng nhau
            children: [
              Expanded(
                child: Align(
                  alignment: showIconFullTextField
                      ? Alignment.topCenter
                      : Alignment.center,
                  child: TextField(
                    focusNode: widget.focusNode,
                    autofocus: widget.isAutofocus,
                    controller: widget.inputController,
                    minLines: 1,
                    maxLines: showFullInputChat &&
                            widget.inputController.text.isNotEmpty
                        ? null
                        : maxLines,
                    cursorColor: AppColors.c_blue,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: AppSizeText.sizeText12),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .translate('askChatBotAI'),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        top: 6,
                        bottom: 6,
                      ),
                      hintStyle: const TextStyle(
                        fontSize: AppSizeText.sizeText12,
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    scrollPhysics: showFullInputChat &&
                            widget.inputController.text.isNotEmpty
                        ? null
                        : const BouncingScrollPhysics(), // thêm hiệu ứng cuộn
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
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
                    IconButton(
                        onPressed: widget.pressSendMessage,
                        icon: Icon(Icons.send)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
