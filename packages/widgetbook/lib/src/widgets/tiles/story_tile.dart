import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/navigation/preview_provider.dart';
import 'package:widgetbook/src/utils/utils.dart';
import 'package:widgetbook/src/widgets/tiles/spaced_tile.dart';

class StoryTile extends StatefulWidget {
  const StoryTile({
    Key? key,
    required this.useCase,
    required this.level,
  }) : super(key: key);

  final WidgetbookUseCase useCase;
  final int level;

  @override
  _StoryTileState createState() => _StoryTileState();
}

class _StoryTileState extends State<StoryTile> {
  @override
  Widget build(BuildContext context) {
    return SpacedTile(
      level: widget.level,
      organizer: widget.useCase,
      iconData: Icons.auto_stories,
      iconColor: Styles.storyColor,
      onClicked: () {
        context.read<PreviewProvider>().selectUseCase(widget.useCase);
      },
    );
  }
}
