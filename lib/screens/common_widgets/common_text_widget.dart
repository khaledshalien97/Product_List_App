import 'package:flutter/material.dart';

Widget commonTextWidget({
  String? text,
  double? fontSize,
  Color? color,
  TextOverflow? textoverflow,
  FontWeight? fontWeight,
  TextAlign? textAlign,
}) {
  return Text(
    text!,
    style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
    overflow: textoverflow,
    textAlign: textAlign,
  );
}
