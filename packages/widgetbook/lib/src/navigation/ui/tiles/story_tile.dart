import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/src/cubit/canvas/canvas_cubit.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/navigation/ui/tiles/spaced_tile.dart';
import '../../../utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryTile extends StatefulWidget {
  final Story story;
  final int level;

  const StoryTile({
    Key? key,
    required this.story,
    required this.level,
  }) : super(key: key);

  @override
  _StoryTileState createState() => _StoryTileState();
}

class _StoryTileState extends State<StoryTile> {
  @override
  Widget build(BuildContext context) {
    return SpacedTile(
      level: widget.level,
      organizer: widget.story,
      iconData: Icons.auto_stories,
      iconColor: Styles.storyColor,
      onClicked: () {
        context.read<CanvasCubit>().selectStory(widget.story);
      },
    );
  }
}
