import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class HeaderCus extends StatefulWidget {
  VoidCallback? fnLeftPress;
  VoidCallback? fnRightPress;
  bool? isShowChatHistoryChat;
  String title;
  IconData iconData;

  HeaderCus(
      {super.key,
      this.fnLeftPress,
      this.fnRightPress,
      this.isShowChatHistoryChat = false,
      this.title = '',
      this.iconData = Icons.messenger_outline});

  @override
  State<HeaderCus> createState() => _HeaderCusState();
}

class _HeaderCusState extends State<HeaderCus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: widget.fnLeftPress,
            child: Icon(
              widget.iconData,
              size: 28,
            ),
          ),
          textCus(
            context: context,
            // text: widget.isShowChatHistoryChat ? 'conversation' : 'appName',
            text: widget.title,
            fontWeight: FontWeight.w600,
            fontSize: AppSizeText.sizeText14,
          ),
          GestureDetector(
            onTap: widget.fnRightPress,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://img.amiami.jp/images/product/review/191/TOY-RBT-4827_01.jpg?a8=YRvtwRALNEponvKc_hc6iFP2Fo9wjLvg4L0sTMfLuRzCu.zLNCuEusHcDFvoJFngVFPg_6uFSqvYuRQoNFP2tjZ5xs00000003017001'),
            ),
          )
        ],
      ),
    );
  }
}
