import 'package:flutter/material.dart';
import 'package:product_list_app/core/app_colors.dart';
import 'package:product_list_app/screens/common_widgets/common_text_widget.dart';

AppBar commonAppBar({required String title}) {
  return AppBar(
    backgroundColor: AppColors.deepCyan,
    foregroundColor: AppColors.white,
    centerTitle: false,
    title: commonTextWidget(
      text: title,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      textoverflow: TextOverflow.ellipsis,
    ),
  );
}
