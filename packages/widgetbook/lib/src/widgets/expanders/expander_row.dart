import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';

import 'package:widgetbook/src/widgets/expanders/expand_button.dart';

class ExpanderRow extends StatefulWidget {
  const ExpanderRow({
    Key? key,
    this.size,
    required this.organizers,
  }) : super(key: key);

  final double? size;
  final List<ExpandableOrganizer> organizers;

  @override
  _ExpanderRowState createState() => _ExpanderRowState();
}

class _ExpanderRowState extends State<ExpanderRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandButton(
          organizers: widget.organizers,
          expandTo: true,
        ),
        ExpandButton(
          organizers: widget.organizers,
          expandTo: false,
        ),
      ],
    );
  }
}
