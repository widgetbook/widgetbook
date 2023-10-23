import 'package:cookbook1/utils/color.dart';
import 'package:flutter/material.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class CustomTitleText extends StatelessWidget {
  const CustomTitleText({
    required this.titleText,
    required this.titleTextColor,
    super.key,
  });
  final String titleText;
  final Color titleTextColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: TextStyle(color: titleTextColor),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default Style',
  type: CustomTitleText,
)
CustomTitleText defaultCustomTitle(BuildContext context) {
  return const CustomTitleText(
    titleText: 'login page',
    titleTextColor: AppColor.myWhite,
  );
}

@widgetbook.UseCase(
  name: 'blue color',
  type: CustomTitleText,
)
CustomTitleText blueColor(BuildContext context) {
  return const CustomTitleText(
    titleText: 'login page',
    titleTextColor: AppColor.appblueColor,
  );
}
