import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widgetbook_example/widgets/attributes/attribute.dart';

class PriceAttribute extends StatelessWidget {
  final num price;
  const PriceAttribute({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Attribute(
      attribute: '\$${price.toStringAsFixed(2)}',
      iconData: FontAwesomeIcons.tag,
    );
  }
}
