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

  List<ChatModel> dataChat = [];

  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();

    if (widget.message!.isNotEmpty) {
      setState(() {
        inputController.text = widget.message ?? "";
      });
      dataChat.add(ChatModel(role: "user", content: widget.message ?? ''));
      context.read<ChatBloc>().add(SendMessage(message: widget.message ?? ''));
    }
  }

  void handleSendMessage() {
    if (inputController.text.trim().isEmpty) return;
    setState(() {
      dataChat.add(ChatModel(role: "user", content: inputController.text));
    });
    context.read<ChatBloc>().add(SendMessage(message: inputController.text));
    inputController.clear();
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
            dataChat
                .add(ChatModel(role: "assistant", content: chatState.message));
          });
        }
      },
      child: Expanded(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Expanded(
                child: ListView.builder(
                  primary: false,
                  itemCount: dataChat.length,
                  itemBuilder: (context, index) {
                    final message = dataChat[index];
                    return message.role == "user"
                        ? MessageUser(message: message.content)
                        : MessageChatBoxAI(message: message.content);
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
