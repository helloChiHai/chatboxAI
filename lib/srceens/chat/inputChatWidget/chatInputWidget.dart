import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/chatBloc/chat_bloc.dart';
import 'package:stock_flutter/bloc/chatBloc/chat_event.dart';
import 'package:stock_flutter/bloc/chatBloc/chat_state.dart';
import 'package:stock_flutter/models/chat_model.dart';
import 'package:stock_flutter/srceens/chat/inputChatWidget/messageChatBoxAI.dart';
import 'package:stock_flutter/srceens/chat/inputChatWidget/messageUser.dart';
import 'package:stock_flutter/widgets/inputCus.dart';

class ChatInputWidget extends StatefulWidget {
  bool isGoNextScreen; // true: được chuyển màn; false: không cho chuyển màn
  String? message;

  ChatInputWidget({
    super.key,
    required this.isGoNextScreen,
    required this.message,
  });

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  late TextEditingController inputController;
  bool showIconFullTextField = false;
  int maxLines = 6;
  double borderRadius = 30;
  bool showFullInputChat = false;
  bool checkLoadMessage =
      false; // kiểm tra có đang chờ tin nhắn từ ChatBox AI không? true: đang chờ; false: khôgn chờ
  final FocusNode inputNode = FocusNode();
  int count =
      0; // dùng để phân biệt tin nhắn của chat trong dataChat, phân biệt chổ tin nào để hiển thị load chổ đó
  List<ChatModel> dataChat = [];
  final ScrollController scrollController =
      ScrollController(); // kiểm soát cuộn của listviewbuilder

  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();

    if (widget.message!.isNotEmpty) {
      dataChat.add(ChatModel(role: "user", body: widget.message ?? ''));
      context.read<ChatBloc>().add(SendMessage(message: widget.message ?? ''));
    }
  }

  void handleSendMessage() {
    if (inputController.text.trim().isEmpty) return;

    setState(() {
      count = count + 2;
      dataChat.add(ChatModel(role: "user", body: inputController.text.trim()));
      checkLoadMessage = true;
    });

    context
        .read<ChatBloc>()
        .add(SendMessage(message: inputController.text.trim()));

    inputController.dispose(); // Giải phóng controller cũ
    inputController = TextEditingController(); // Tạo controller mới

    Future.delayed(const Duration(milliseconds: 100), scrollToBottom);
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, chatState) {
        if (chatState is ChatLoading) {
          setState(() {
            checkLoadMessage = true;
          });
        } else if (chatState is ChatSuccess) {
          setState(() {
            checkLoadMessage = false;
            dataChat.add(ChatModel(role: "assistant", body: chatState.message));
          });
          Future.delayed(const Duration(milliseconds: 100), scrollToBottom);
        } else if (chatState is ChatError) {
          setState(() {
            checkLoadMessage = false;
            dataChat.add(ChatModel(role: "assistant", body: chatState.error));
          });
          Future.delayed(const Duration(milliseconds: 100), scrollToBottom);
        }
      },
      child: Expanded(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: dataChat.length,
                  itemBuilder: (context, index) {
                    final message = dataChat[index];
                    return message.role == "user"
                        ? MessageUser(
                            message: message.body,
                            index: index,
                            count: count,
                            isLoad: checkLoadMessage,
                          )
                        : MessageChatBoxAI(
                            message: message.body,
                            scrollController: scrollController,
                            index: index,
                          );
                  },
                ),
              ),
              InputCus(
                pressSendMessage: handleSendMessage,
                inputController: inputController,
                isAutofocus: false,
                focusNode: inputNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
