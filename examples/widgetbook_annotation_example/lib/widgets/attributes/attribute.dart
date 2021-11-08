import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookUseCase(name: 'weight', type: Attribute)
Widget attributeStory(BuildContext context) {
  return Attribute(
    attribute: 'Weight',
    iconData: Icons.watch,
  );
}

class Attribute extends StatelessWidget {
  final String attribute;
  final IconData iconData;
  const Attribute({
    Key? key,
    required this.attribute,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(
          iconData,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          attribute,
        ),
      ],
    );
  }
}
