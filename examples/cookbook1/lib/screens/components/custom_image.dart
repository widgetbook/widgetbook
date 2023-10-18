import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class CustomImage extends StatelessWidget {
  const CustomImage({
    required this.height,
    required this.width,
    super.key,
  });
  final double height;
  final double width;


  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/cooking.jpg",
      height: height,
      width: width,
      fit: BoxFit.contain,
    );
  }
}
@widgetbook.UseCase(
  name: 'Default Style',
  type: CustomImage,
)
CustomImage defaultSize(BuildContext context) {
  return const CustomImage(
    height: 300,
    width: 300,
  );
}
@widgetbook.UseCase(
  name: 'small size',
  type: CustomImage,
)
CustomImage defaultSmallSize(BuildContext context) {
  return const CustomImage(
    height: 100,
    width: 100,
  );
}