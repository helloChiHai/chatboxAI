import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class BgUserInformation extends StatelessWidget {
  const BgUserInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
          // color: themeState.themeMode != ThemeMode.light
          //     ? AppColors.backgroundColor
          //     : AppColors.c_darkmode,
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                'https://img.amiami.jp/images/product/review/191/TOY-RBT-4827_01.jpg?a8=YRvtwRALNEponvKc_hc6iFP2Fo9wjLvg4L0sTMfLuRzCu.zLNCuEusHcDFvoJFngVFPg_6uFSqvYuRQoNFP2tjZ5xs00000003017001'),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textCus(
                context: context,
                text: 'Vương Chí Hải',
                fontSize: AppSizeText.sizeText14,
                fontWeight: FontWeight.w600,
                // color:
                //     themeState.themeMode == ThemeMode.dark
                //         ? AppColors.backgroundColor
                //         : AppColors.c_black,
                color: AppColors.c_black,
              ),
              textCus(
                context: context,
                text: 'vuongchihai0711@gmail.com',
                fontSize: AppSizeText.sizeText14,
                color: AppColors.c_black_54,
                //  themeState.themeMode == ThemeMode.dark
                // ? AppColors.backgroundColor
                // : AppColors.c_black_54,
              ),
            ],
          )
        ],
      ),
    );
  }
}
