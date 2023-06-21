import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.borderRadius = 8.0,
  });

  final Widget child;
  final Color backgroundColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}

@widgetbook.UseCase(
  name: 'Default Style',
  type: CustomCard,
)
CustomCard defaultCustomCard(BuildContext context) {
  return const CustomCard(
    child: Text('This is a custom card'),
  );
}

@widgetbook.UseCase(
  name: 'With Custom Background Color',
  type: CustomCard,
)
CustomCard customBackgroundCustomCard(BuildContext context) {
  return CustomCard(
    backgroundColor: Colors.green.shade100,
    child: const Text('This is a custom card with a custom background color'),
  );
}
