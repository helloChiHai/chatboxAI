import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/srceens/chatHistoryList/chatHistoryList.dart';
import 'package:stock_flutter/srceens/home/textHelloUser.dart';
import 'package:stock_flutter/srceens/setting/setting.dart';
import 'package:stock_flutter/widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isShowChatHistoryChat = false;
  String titleHeader = 'appName';
  late TextEditingController inputController;

  @override
  void initState() {
    inputController = TextEditingController();
    super.initState();
  }

  void handleShowChatHistoryList() {
    setState(() {
      isShowChatHistoryChat = !isShowChatHistoryChat;
      titleHeader = isShowChatHistoryChat ? 'conversation' : 'appName';
    });
  }

  void handleShowSetting(BuildContext context) {
    showCustomDialog(context);
  }

  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 40, bottom: 25),
        child: Column(
          children: [
            HeaderCus(
              fnLeftPress: handleShowChatHistoryList,
              fnRightPress: () => handleShowSetting(context),
              iconData: isShowChatHistoryChat
                  ? Icons.arrow_back_ios
                  : Icons.messenger_outline,
              title: titleHeader,
            ),
            isShowChatHistoryChat
                ? const ChatHistoryList()
                : const HelloUserWidget()
          ],
        ),
      ),
    );
  }
}
