import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widgetbook_example/widgets/attributes/attribute.dart';

class WeightAttribute extends StatelessWidget {
  final num weight;
  const WeightAttribute({
    Key? key,
    required this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Attribute(
      attribute: '${weight}g',
      iconData: FontAwesomeIcons.weight,
    );
  }
}
