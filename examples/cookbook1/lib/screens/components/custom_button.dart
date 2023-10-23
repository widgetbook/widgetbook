import 'package:cookbook1/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.buttonTitle,
    required this.onPressed,
    required this.buttonbackColor,
    super.key,
  });
  final String buttonTitle;
  final VoidCallback onPressed;
  final Color buttonbackColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        key: key,
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          color: buttonbackColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonTitle,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'default',
  type: CustomButton,
)
CustomButton blackColorButton(BuildContext context) {
  return CustomButton(
    buttonTitle: 'Login',
    onPressed: () {},
    buttonbackColor: AppColor.buttonColor,
  );
}

@widgetbook.UseCase(
  name: 'blue button',
  type: CustomButton,
)
CustomButton blueColorButton(BuildContext context) {
  return CustomButton(
    buttonTitle: 'Login',
    onPressed: () {},
    buttonbackColor: AppColor.buttonbackColorBlue,
  );
}
