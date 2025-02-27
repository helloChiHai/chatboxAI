import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/chatBloc/chat_bloc.dart';
import 'package:stock_flutter/bloc/chatBloc/chat_event.dart';
import 'package:stock_flutter/bloc/chatBloc/chat_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/srceens/chat/inputChatWidget/messageChatBoxAI.dart';
import 'package:stock_flutter/srceens/chat/inputChatWidget/messageUser.dart';
import 'package:stock_flutter/widgets/inputCus.dart';

class ChatInputWidget extends StatefulWidget {
  ChatInputWidget({
    super.key,
  });

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final TextEditingController inputController = TextEditingController();
  bool showIconFullTextField = false;
  int maxLines = 6;
  double borderRadius = 30;
  bool showFullInputChat = false;

  List<Map<String, dynamic>> dataChat = [];
  bool isLoading = true; // trạng thái loading
  bool hasMore = true; // kiểm tra có cần load thêm không
  int page = 1; // trang hiện tại
  final int perPage = 40; // số lượng item mỗi lần load
  final ScrollController scrollController = ScrollController(); // theo dõi cuộn
  bool isShowHelloText = true; // true: hiển thị; false: ẩn đi

  @override
  void initState() {
    super.initState();
    inputController.addListener(getTextLineCount);
    fetchDataChat();

    // lắng nghe sự kiện cuộn để load thêm dữ liệu
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchDataChat();
      }
    });
  }

  Future<void> fetchDataChat() async {
    if (!hasMore) return;

    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    await Future.delayed(Duration(seconds: 1));

    List<Map<String, dynamic>> newDataChat = List.generate(
      perPage,
      (index) => {
        'message': 'Tin nhắn ${(page - 1) * perPage + index + 1}',
        'isUser': (index % 2 == 0), // Giả lập tin nhắn của user và friend
      },
    );

    if (mounted) {
      setState(() {
        dataChat.addAll(newDataChat);
        page++;
        if (newDataChat.length < perPage) {
          hasMore =
              false; // nếu sl item nhận về ít hơn perPage, tức lả hết dữ liệu
        }
        isLoading = false;
      });
    }
  }

  void getTextLineCount() {
    final span = TextSpan(
      text: inputController.text,
      style: TextStyle(fontSize: AppSizeText.sizeText12),
    );
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: MediaQuery.of(context).size.width - 32);

    final numLines = tp.computeLineMetrics().length;

    if (mounted) {
      setState(() {
        showIconFullTextField = numLines >= 4;

        borderRadius = numLines >= 2 ? 20 : 30;
      });
    }
  }

  void handleSendMessage() {
    // setState(() {
    //   isShowHelloText = false;
    // });
    context.read<ChatBloc>().add(SendMessage(message: inputController.text));
    inputController.clear();
  }

  @override
  void dispose() {
    inputController.removeListener(getTextLineCount);
    scrollController.removeListener(fetchDataChat);
    inputController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            // showFullInputChat || !isShowHelloText
            //     ? SizedBox(height: 10)
            //     : ShaderMaskHelloUser(
            //         userName: 'Vương Chí Hải',
            //       ),
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, chatState) {
                  if (chatState.isLoading) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    itemCount: chatState.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatState.messages[index];
                      return message["role"] == "user"
                          ? MessageUser(message: message["content"])
                          : MessageChatBoxAI(message: message["content"]);
                    },
                  );
                },
              ),
            ),
            InputCus(
              pressSendMessage: handleSendMessage,
              inputController: inputController,
            ),
          ],
        ),
      ),
    );
  }
}


   // Expanded(
            //   child: Container(
            //     child: isLoading && dataChat.isEmpty
            //         ? Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         : dataChat.isEmpty
            //             ? Center(
            //                 child: textCus(
            //                     context: context, text: 'noDataAvailable'),
            //               )
            //             : ListView.builder(
            //                 controller: scrollController,
            //                 itemCount: dataChat.length + (hasMore ? 1 : 0),
            //                 itemBuilder: (context, index) {
            //                   if (index == dataChat.length) {
            //                     return Center(
            //                         child: CircularProgressIndicator());
            //                   }
            //                   final chatItem = dataChat[index];
            //                   final bool isUser = chatItem['isUser'];
            //                   final String message = chatItem['message'];

            //                   return Align(
            //                     alignment: isUser
            //                         ? Alignment.centerRight
            //                         : Alignment.centerLeft,
            //                     child: ItemChat(
            //                       isUser: isUser,
            //                       message: message,
            //                     ),
            //                   );
            //                 },
            //               ),
            //   ),
            // ),