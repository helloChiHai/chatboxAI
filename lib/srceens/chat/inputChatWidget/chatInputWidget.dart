// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/constants/localization.dart';
import 'package:stock_flutter/srceens/chat/inputChatWidget/itemChat.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

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

    print(newDataChat);

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
    print(inputController.text.trim());
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
            // showFullInputChat
            //     ? SizedBox(height: 10)
            //     : ShaderMaskHelloUser(
            //         userName: 'Vương Chí Hải',
            //       ),
            Expanded(
              child: Container(
                child: isLoading && dataChat.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : dataChat.isEmpty
                        ? Center(
                            child: textCus(
                                context: context, text: 'noDataAvailable'),
                          )
                        : ListView.builder(
                            controller: scrollController,
                            itemCount: dataChat.length + (hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == dataChat.length) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              final chatItem = dataChat[index];
                              final bool isUser = chatItem['isUser'];
                              final String message = chatItem['message'];

                              return Align(
                                alignment: isUser
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: ItemChat(
                                  isUser: isUser,
                                  message: message,
                                ),
                              );
                            },
                          ),
              ),
            ),
            Expanded(
              flex: showFullInputChat ? 1 : 0,
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
                            style: TextStyle(fontSize: AppSizeText.sizeText12),
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)
                                  .translate('askChatBotAI'),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 15,
                                top: 10,
                                bottom: 10,
                              ),
                              hintStyle: TextStyle(
                                fontSize: AppSizeText.sizeText12,
                              ),
                            ),
                            keyboardType: TextInputType.multiline,
                            scrollPhysics:
                                BouncingScrollPhysics(), // thêm hiệu ứng cuộn
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
                            GestureDetector(
                              onTap: handleSendMessage,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.c_gray_255_217,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
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
