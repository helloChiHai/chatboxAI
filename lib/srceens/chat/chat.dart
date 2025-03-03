import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/srceens/chat/inputChatWidget/chatInputWidget.dart';
import 'package:stock_flutter/srceens/setting/setting.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/header.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? message;

  @override
  void initState() {
    super.initState();
  }

  String titleHeader = 'appName';

  void handleBoback(BuildContext context) {
    Utils.navigatorGoBack(context);
  }

  void handleGoSetting(BuildContext context) {
    showCustomDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    message = args["message"] ?? '';

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
              fnLeftPress: () => handleBoback(context),
              fnRightPress: () => handleGoSetting(context),
              iconData: Icons.arrow_back_ios,
              title: titleHeader,
            ),
            ChatInputWidget(isGoNextScreen: false, message: message)
          ],
        ),
      ),
    );
  }
}
