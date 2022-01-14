import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';

import 'package:widgetbook/src/widgets/expanders/expand_button.dart';

class ExpanderRow extends StatelessWidget {
  const ExpanderRow({
    Key? key,
    this.size,
    required this.organizers,
  }) : super(key: key);

  final double? size;
  final List<ExpandableOrganizer> organizers;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandButton(
          organizers: organizers,
          expandTo: true,
          size: size,
        ),
        ExpandButton(
          organizers: organizers,
          expandTo: false,
          size: size,
        ),
      ],
    );
  }
}
