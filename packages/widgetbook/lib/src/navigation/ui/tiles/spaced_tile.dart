import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/organizers/organizer_base.dart';
import 'package:widgetbook/src/navigation/ui/tiles/tile.dart';
import 'package:widgetbook/src/navigation/ui/tiles/tile_spacer.dart';

class SpacedTile extends StatelessWidget {
  final int level;
  final OrganizerBase organizer;
  final IconData iconData;
  final Color iconColor;
  final VoidCallback? onClicked;

  const SpacedTile({
    Key? key,
    required this.organizer,
    required this.level,
    required this.iconData,
    required this.iconColor,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TileSpacer(level: level),
        Tile(
          iconData: iconData,
          iconColor: iconColor,
          organizer: organizer,
          onClicked: onClicked,
        ),
      ],
    );
  }
}
