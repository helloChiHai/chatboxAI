import 'package:flutter/material.dart';
import 'package:stock_flutter/models/user_model.dart';
import 'package:stock_flutter/repositories/auth_repository.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/services/service_locator.dart';
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
  final FocusNode inputNode =
      FocusNode(); // tắt focus đẻ khi nhấn ra ngoài thì bàn phím đóng đi

  Future<User?>? userFuture;

  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();
    getUserInformation();
  }

  void getUserInformation() {
    setState(() {
      userFuture = locator<AuthRepository>().getUserFromStorage();
    });
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
      child: FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text('Không load được dữ liệu'),
            );
          }

          final user = snapshot.data;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                ShaderMaskHelloUser(
                    userName: user!.userName.isNotEmpty ? user.userName : ''),
                InputCus(
                  pressSendMessage: handleGoChat,
                  inputController: inputController,
                  isAutofocus: false,
                  focusNode: inputNode,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
