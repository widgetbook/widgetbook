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
          height: 60,
          width: 300,
          decoration: BoxDecoration(
              color: buttonbackColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: TextButton(
              onPressed: onPressed,
              child: Text(
                buttonTitle,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                ),
              ))),
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
    buttonbackColor: const Color.fromARGB(255, 255, 255, 255),
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
    buttonbackColor: const Color.fromARGB(255, 22, 7, 233),
  );
}
