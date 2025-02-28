import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';
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
      body: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode,
        builder: (context, themeState) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              // color: themeState.themeMode == ThemeMode.dark
              //     ? AppColors.c_darkmode
              //     : AppColors.backgroundColor,
            ),
            padding: EdgeInsets.only(right: 10, left: 10, top: 40, bottom: 25),
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
                isShowChatHistoryChat ? ChatHistoryList() : HelloUserWidget()
              ],
            ),
          );
        },
      ),
    );
  }
}
