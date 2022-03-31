import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
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
      tooltip = 'Expand all';
    } else {
      icon = Icons.expand_less;
      tooltip = 'Collapse all';
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
          context
              .read<OrganizerProvider>()
              .setExpandedRecursive(widget.organizers, widget.expandTo);
        },
      ),
    );
  }
}
