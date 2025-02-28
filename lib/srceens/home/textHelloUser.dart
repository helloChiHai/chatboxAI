import 'package:flutter/material.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/inputCus.dart';
import 'package:stock_flutter/widgets/shaderMaskHelloUser.dart';

class HelloUserWidget extends StatefulWidget {
  HelloUserWidget({super.key});

  @override
  State<HelloUserWidget> createState() => _HelloUserWidgetState();
}

class _HelloUserWidgetState extends State<HelloUserWidget> {
  late TextEditingController inputController;
  bool showIconFullTextField = false;
  int maxLines = 6;
  double borderRadius = 30;
  bool showFullInputChat = false;

  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();
  }

  void handleGoChat() {
    if (inputController.text.trim().isEmpty) return;

    Utils.navigatorFadeTransition(context, AppRoutes.chat,
        arguments: {'message': inputController.text});
    inputController.clear();
  }

  @override
  void dispose() {
    inputController.dispose();
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
            ShaderMaskHelloUser(userName: 'Vương Chí Hải'),
            InputCus(
              pressSendMessage: handleGoChat,
              inputController: inputController,
            ),
          ],
        ),
      ),
    );
  }
}
