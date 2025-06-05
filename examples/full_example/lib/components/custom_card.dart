import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
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
  path: '[components]/CustomCard/default_style',
)
Widget defaultCustomCard(BuildContext context) {
  return Column(
    children: [
      const CustomCard(child: Text('This is a custom card')),
      ElevatedButton(
        onPressed: () {
          WidgetbookState.of(context).open(
            'widgets/containers/container/component',
          );
        },
        child: const Text('Go to Container'),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'With Custom Background Color',
  type: CustomCard,
  path: '[components]/CustomCard/with_custom_background_color',
)
CustomCard customBackgroundCustomCard(BuildContext context) {
  return CustomCard(
    backgroundColor: Colors.green.shade100,
    child: const Text('This is a custom card with a custom background color'),
  );
}
