import 'package:flutter/material.dart';
import 'package:widgetbook/src/providers/organizer_provider.dart';
import 'package:widgetbook/widgetbook.dart';

class ExpandButton extends StatefulWidget {
  const ExpandButton({
    Key? key,
    required this.organizers,
    required this.expandTo,
    this.size = 17,
  }) : super(key: key);

  final List<ExpandableOrganizer> organizers;
  final bool expandTo;
  final double? size;

  @override
  _ExpandButtonState createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<ExpandButton> {
  @override
  Widget build(BuildContext context) {
    IconData icon;
    String tooltip;
    if (widget.expandTo) {
      icon = Icons.expand_more;
      tooltip = 'Expand';
    } else {
      icon = Icons.expand_less;
      tooltip = 'Collapse';
    }
    return Tooltip(
      message: tooltip,
      waitDuration: const Duration(milliseconds: 500),
      child: InkWell(
        child: Icon(
          icon,
          size: widget.size,
        ),
        onTap: () {
          OrganizerProvider.of(context)
              ?.setExpandedRecursive(widget.organizers, widget.expandTo);
        },
      ),
    );
  }
}
