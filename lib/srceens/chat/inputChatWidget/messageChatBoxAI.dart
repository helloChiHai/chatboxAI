import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';

class MessageChatBoxAI extends StatefulWidget {
  final String message;
  final ScrollController scrollController;
  final int index;

  MessageChatBoxAI({
    super.key,
    required this.message,
    required this.scrollController,
    required this.index,
  });

  @override
  State<MessageChatBoxAI> createState() => _MessageChatBoxAIState();
}

class _MessageChatBoxAIState extends State<MessageChatBoxAI> {
  String displayMessage = "";
  int currentIndex = 0;
  Timer? timer;
  static final Map<int, String> cacheMessages = {}; // lưu trạng thái tin nhắn

  @override
  void initState() {
    super.initState();

    handleCheckCacheMessages();
  }

  void handleCheckCacheMessages() {
    if (cacheMessages.containsKey(widget.index)) {
      // nếu tin nhắn đã hiển thị trước đó, dùng lại thay vì rebuild lại
      displayMessage = cacheMessages[widget.index]!;
      currentIndex = displayMessage.length;
    } else {
      startTypingEffec();
    }
  }

  void startTypingEffec() {
    timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (currentIndex < widget.message.length) {
          setState(() {
            displayMessage += widget.message[currentIndex];
            currentIndex++;
            cacheMessages[widget.index] =
                displayMessage; // lưu trạng thái tin nhắn
          });
          Future.delayed(const Duration(milliseconds: 10), scrollToBottom);
        } else {
          timer.cancel();
        }
      },
    );
  }

  void scrollToBottom() {
    if (widget.scrollController.hasClients) {
      widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          SelectableText(
            displayMessage,
            style: const TextStyle(
                fontSize: AppSizeText.sizeText12, color: AppColors.c_black),
          )
        ],
      ),
    );
  }
}
