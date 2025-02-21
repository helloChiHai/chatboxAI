import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';
import 'package:stock_flutter/srceens/chat/inputChatWidget/messageChatBoxAI.dart';
import 'package:stock_flutter/srceens/chat/inputChatWidget/messageUser.dart';

class ItemChat extends StatelessWidget {
  String message;
  bool isUser;
  ItemChat({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, themeState) {
        return isUser
            ? MessageUser(
                message: message,
                themeState: themeState.themeMode,
              )
            : MessageChatBoxAI(
                message: message, themeState: themeState.themeMode);
      },
    );
  }
}
