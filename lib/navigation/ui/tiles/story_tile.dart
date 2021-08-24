import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/cubit/canvas/canvas_cubit.dart';
import 'package:widgetbook/models/organizers/organizers.dart';
import 'package:widgetbook/navigation/ui/tiles/spaced_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      iconData: FontAwesomeIcons.file,
      iconColor: Styles.storyColor,
      onClicked: () {
        Navigator.of(context)
            .pushReplacementNamed('/stories/${widget.story.path}');
        context.read<CanvasCubit>().selectStory(widget.story);
      },
    );
  }
}
