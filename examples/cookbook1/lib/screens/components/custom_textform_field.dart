import 'package:cookbook1/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    required this.textFieldColor,
    required this.suffixIcon,
    required this.obscureText,
    super.key,
  });
  final TextEditingController controller;
  final String hintText;
  final Color textFieldColor;
  final IconData suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        key: key,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        decoration: InputDecoration(
          fillColor: textFieldColor,
          hintText: hintText,
          suffixIcon: Icon(
            suffixIcon,
            color: textFieldColor,
          ),
          hintStyle: TextStyle(color: textFieldColor),
          hoverColor: textFieldColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: textFieldColor, width: 3),
          ),
          enabled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: textFieldColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: textFieldColor),
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'yellow field color',
  type: CustomTextFormField,
)
CustomTextFormField defaultCustomTitle(BuildContext context) {
  TextEditingController testController = TextEditingController();
  return CustomTextFormField(
    controller: testController,
    hintText: 'hello',
    textFieldColor: AppColor.appYellowColor,
    suffixIcon: Icons.headphones,
    obscureText: true,
  );
}

@widgetbook.UseCase(
  name: 'blue field color',
  type: CustomTextFormField,
)
CustomTextFormField defaultCustomTitle1(BuildContext context) {
  TextEditingController testController = TextEditingController();
  return CustomTextFormField(
    controller: testController,
    hintText: 'hello',
    textFieldColor: AppColor.appblueColor,
    suffixIcon: Icons.headphones,
    obscureText: true,
  );
}
