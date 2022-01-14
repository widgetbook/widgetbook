import 'package:flutter/material.dart';
import 'package:widgetbook/src/providers/organizer_provider.dart';
import 'package:widgetbook/widgetbook.dart';

class ExpandButton extends StatefulWidget {
  const ExpandButton({
    Key? key,
    required this.organizers,
    required this.expandTo,
  }) : super(key: key);

  final List<ExpandableOrganizer> organizers;
  final bool expandTo;

  @override
  _ExpandButtonState createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<ExpandButton> {
  @override
  Widget build(BuildContext context) {
    final icon = widget.expandTo ? Icons.expand_more : Icons.expand_less;
    return GestureDetector(
      child: Icon(
        icon,
        size: 17,
      ),
      onTap: () {
        OrganizerProvider.of(context)
            ?.setExpandedRecursive(widget.organizers, widget.expandTo);
      },
    );
  }
}
