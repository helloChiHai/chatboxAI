import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/srceens/chatHistoryList/chatHistoryList.dart';
import 'package:stock_flutter/srceens/chat/chatInputWidget.dart';
import 'package:stock_flutter/srceens/setting/setting.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/header.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isShowChatHistoryChat = false;
  String titleHeader = 'appName';

  void handleBoback(BuildContext context) {
    Utils.navigatorGoBack(context);
  }

  void handleGoSetting(BuildContext context) {
    showCustomDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode,
        builder: (context, themeState) {
          return Container(
            decoration: BoxDecoration(
              color: themeState.themeMode == ThemeMode.dark
                  ? AppColors.c_darkmode
                  : AppColors.backgroundColor,
            ),
            padding: EdgeInsets.only(right: 10, left: 10, top: 40, bottom: 25),
            child: Column(
              children: [
                // hình ảnh + ds chat lưu trữ
                HeaderCus(
                  fnLeftPress: () => handleBoback(context),
                  fnRightPress: () => handleGoSetting(context),
                  iconData: Icons.arrow_back_ios,
                  title: titleHeader,
                ),
                // màn chào tin nhắn
                // danh sách tin nhắn lưu trữ
                isShowChatHistoryChat ? ChatHistoryList() : ChatInputWidget()
              ],
            ),
          );
        },
      ),
    );
  }
}
