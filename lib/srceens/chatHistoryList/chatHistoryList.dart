import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class ChatHistoryList extends StatefulWidget {
  const ChatHistoryList({super.key});

  @override
  State<ChatHistoryList> createState() => _ChatHistoryListState();
}

class _ChatHistoryListState extends State<ChatHistoryList> {
  //
  final List<Map<String, dynamic>> chatData = const [
    {'title': 'today', 'type': 1},
    {'title': 'Random Character Input', 'time': 'today', 'type': 0},
    {'title': 'Gemini: Ready to Assist', 'time': 'today', 'type': 0},
    {'title': 'A Simple Greeting', 'time': 'today', 'type': 0},
    {'title': 'Chào bạn!', 'time': 'today', 'type': 0},
    {'title': 'Pronoun "He" Defined', 'time': 'today', 'type': 0},
    {'title': 'A Simple Greeting', 'time': 'today', 'type': 0},
    {'title': 'Xác định yêu cầu rõ hơn', 'time': 'today', 'type': 0},
    {'title': 'Giới hạn của một mô hình ngôn ngữ', 'time': 'today', 'type': 0},
    {'title': '30daysAgo', 'type': 1},
    {'title': 'Khó Hiểu Ngôn Ngữ', 'time': '30_days_ago'},
    {'title': 'Khó Hiểu Ngôn Ngữ', 'time': '30_days_ago'},
    {'title': 'Khó Hiểu Ngôn Ngữ', 'time': '30_days_ago'},
    {'title': 'Khó Hiểu Ngôn Ngữ', 'time': '30_days_ago'},
  ];

  void handleGoChat() {
    Utils.navigatorBTT(context, AppRoutes.chat);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, themeState) {
        return Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              itemCount: chatData.length,
              itemBuilder: (context, index) {
                return chatData[index]['type'] == 1
                    ? Container(
                        child: textCus(
                            context: context,
                            text: chatData[index]['title'],
                            fontSize: AppSizeText.sizeText14,
                            color: themeState.themeMode == ThemeMode.dark
                                ? AppColors.backgroundColor
                                : AppColors.c_black,
                            fontWeight: FontWeight.w600),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          onPressed: handleGoChat,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                themeState.themeMode == ThemeMode.dark
                                    ? AppColors.c_darkmode
                                    : AppColors.backgroundColor,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            elevation: 0,
                            padding: EdgeInsets.zero,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: themeState.themeMode == ThemeMode.dark
                                      ? AppColors.c_second_darkmode
                                      : AppColors.c_gray_255_217,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.messenger_outline,
                                  color: themeState.themeMode == ThemeMode.dark
                                      ? AppColors.c_white54
                                      : AppColors.c_gray,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: textCus(
                                  context: context,
                                  text: chatData[index]['title'],
                                  fontSize: AppSizeText.sizeText12,
                                  color: themeState.themeMode == ThemeMode.dark
                                      ? AppColors.backgroundColor
                                      : AppColors.c_black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ),
        );
      },
    );
  }
}
