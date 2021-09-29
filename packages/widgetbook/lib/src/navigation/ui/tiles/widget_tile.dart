import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/navigation/ui/tiles/spaced_tile.dart';
import 'package:widgetbook/src/navigation/ui/tiles/story_tile.dart';
import 'package:widgetbook/src/providers/organizer_provider.dart';
import '../../../utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetTile extends StatefulWidget {
  final WidgetElement widgetElement;
  final int level;

  const WidgetTile({
    Key? key,
    required this.widgetElement,
    required this.level,
  }) : super(key: key);

  @override
  _WidgetTileState createState() => _WidgetTileState();
}

class _WidgetTileState extends State<WidgetTile> {
  bool expanded = false;
  bool hover = false;

  List<Widget> _buildStories(int level) {
    List<Story> stories = widget.widgetElement.stories;
    return stories
        .map(
          (Story story) => StoryTile(
            story: story,
            level: level,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpacedTile(
          level: widget.level,
          organizer: widget.widgetElement,
          iconData: Icons.style,
          iconColor: context.colorScheme.secondary,
          onClicked: () {
            OrganizerProvider.of(context)!.toggleExpander(widget.widgetElement);
          },
        ),
        if (widget.widgetElement.isExpanded) ..._buildStories(widget.level + 1),
      ],
    );
  }
}
