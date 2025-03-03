import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

Future<void> showLoadingPage({
  required BuildContext context,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.blue,
                size: 40,
              ),
              textCus(
                context: context,
                text: 'appName',
                color: AppColors.c_darkmode,
                fontWeight: FontWeight.w600,
                fontSize: AppSizeText.sizeText14,
              )
            ],
          ),
        ),
      );
    },
  );
}
