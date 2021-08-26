import 'package:flutter/material.dart';
import 'package:widgetbook/src/cubit/organizer/organizer_cubit.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/navigation/ui/tiles/tile_helper_methods.dart';
import 'package:widgetbook/src/navigation/ui/tiles/spaced_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/utils.dart';

class FolderTile extends StatefulWidget {
  final Folder folder;
  final int level;
  const FolderTile({
    Key? key,
    required this.folder,
    required this.level,
  }) : super(key: key);

  @override
  _FolderTileState createState() => _FolderTileState();
}

class _FolderTileState extends State<FolderTile> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    Folder folder = widget.folder;
    final isExpanded = widget.folder.isExpanded;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpacedTile(
          level: widget.level,
          organizer: widget.folder,
          iconData: isExpanded
              ? FontAwesomeIcons.folderOpen
              : FontAwesomeIcons.folder,
          iconColor: context.colorScheme.primary,
          onClicked: () {
            setState(() {
              context.read<OrganizerCubit>().toggleExpander(widget.folder);
            });
          },
        ),
        if (isExpanded)
          ...buildFolders(
            folders: folder.folders,
            currentLevel: widget.level + 1,
          ),
        if (isExpanded)
          ...buildWidgets(
            widgets: folder.widgets,
            currentLevel: widget.level + 1,
          )
      ],
    );
  }
}
