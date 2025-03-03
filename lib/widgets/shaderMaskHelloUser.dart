import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/constants/localization.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class ShaderMaskHelloUser extends StatelessWidget {
  final String userName;
  const ShaderMaskHelloUser({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            AppColors.c_blue,
            AppColors.c_purple,
            AppColors.c_pink,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: textCus(
        context: context,
        text: "${AppLocalizations.of(context).translate('hello')} $userName",
        fontSize: AppSizeText.sizeText30,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.center,
        color: AppColors.c_white,
      ),
    );
  }
}
