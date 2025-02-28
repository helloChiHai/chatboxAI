import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/models/user_model.dart';
import 'package:stock_flutter/repositories/auth_repository.dart';
import 'package:stock_flutter/services/service_locator.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class BgUserInformation extends StatefulWidget {
  const BgUserInformation({
    super.key,
  });

  @override
  State<BgUserInformation> createState() => _BgUserInformationState();
}

class _BgUserInformationState extends State<BgUserInformation> {
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

        return GestureDetector(
          onTap: () {
            // Utils.navigator(context, AppRoutes.userInformation);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: (user!.img.isEmpty)
                      ? const AssetImage('assets/imgs/logoApp.png')
                          as ImageProvider
                      : NetworkImage(user.img),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textCus(
                      context: context,
                      text: user.userName.isNotEmpty ? user.userName : '',
                      fontSize: AppSizeText.sizeText14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.c_black,
                    ),
                    textCus(
                      context: context,
                      text: user.email.isNotEmpty ? user.email : '',
                      fontSize: AppSizeText.sizeText14,
                      color: AppColors.c_black_54,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
