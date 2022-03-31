import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
import 'package:widgetbook/src/utils/utils.dart';
import 'package:widgetbook/src/widgets/tiles/spaced_tile.dart';
import 'package:widgetbook/src/widgets/tiles/story_tile.dart';

class WidgetTile extends StatefulWidget {
  const WidgetTile({
    Key? key,
    required this.widgetElement,
    required this.level,
  }) : super(key: key);

  final WidgetbookComponent widgetElement;
  final int level;

  @override
  _WidgetTileState createState() => _WidgetTileState();
}

class _WidgetTileState extends State<WidgetTile> {
  bool expanded = false;
  bool hover = false;

  List<Widget> _buildStories(int level) {
    final stories = widget.widgetElement.useCases;

    return stories
        .map(
          (WidgetbookUseCase story) => StoryTile(
            useCase: story,
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
            context
                .read<OrganizerProvider>()
                .toggleExpander(widget.widgetElement);
          },
        ),
        if (widget.widgetElement.isExpanded) ..._buildStories(widget.level + 1),
      ],
    );
  }
}
