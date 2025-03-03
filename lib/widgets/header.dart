import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/models/user_model.dart';
import 'package:stock_flutter/repositories/auth_repository.dart';
import 'package:stock_flutter/services/service_locator.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class HeaderCus extends StatefulWidget {
  VoidCallback? fnLeftPress;
  VoidCallback? fnRightPress;
  String title;
  IconData iconData;

  HeaderCus(
      {super.key,
      this.fnLeftPress,
      this.fnRightPress,
      this.title = '',
      this.iconData = Icons.messenger_outline});

  @override
  State<HeaderCus> createState() => _HeaderCusState();
}

class _HeaderCusState extends State<HeaderCus> {
  Future<User?>? userFuture;

  @override
  void initState() {
    super.initState();
    getUserInformation();
  }

  void getUserInformation() {
    setState(() {
      userFuture = locator<AuthRepository>().getUserFromStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Center(
            child: Text('Không load được dữ liệu'),
          );
        }

        final user = snapshot.data;

        return Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: widget.fnLeftPress,
                child: Icon(widget.iconData),
              ),
              // GestureDetector(
              //   onTap: widget.fnLeftPress,
              //   child: const Image(
              //     image: AssetImage(
              //       'assets/imgs/comments.png',
              //     ),
              //     height: 28,
              //     width: 28,
              //   ),
              // ),
              textCus(
                  context: context,
                  text: widget.title,
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizeText.sizeText16,
                  color: AppColors.c_black),
              GestureDetector(
                onTap: widget.fnRightPress,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: (user!.img.isEmpty)
                      ? const AssetImage('assets/imgs/logoApp.png')
                          as ImageProvider
                      : NetworkImage(user.img),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
