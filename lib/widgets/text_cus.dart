import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/constants/localization.dart';

Widget textCus({
  required BuildContext context,
  required String text,
  double fontSize = AppSizeText.sizeText12,
  FontWeight fontWeight = FontWeight.normal,
  Color? color,
  TextAlign textAlign = TextAlign.start,
}) {
  return Text(
    AppLocalizations.of(context).translate(text),
    style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: TextDecoration.none,
        overflow: TextOverflow.ellipsis),
    textAlign: textAlign,
    maxLines: 2,
  );
}
