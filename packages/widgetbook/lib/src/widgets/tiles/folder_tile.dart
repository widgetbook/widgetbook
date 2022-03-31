import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
import 'package:widgetbook/src/utils/utils.dart';
import 'package:widgetbook/src/widgets/tiles/spaced_tile.dart';
import 'package:widgetbook/src/widgets/tiles/tile_helper_methods.dart';

class FolderTile extends StatefulWidget {
  const FolderTile({
    Key? key,
    required this.folder,
    required this.level,
  }) : super(key: key);

  final WidgetbookFolder folder;
  final int level;

  @override
  _FolderTileState createState() => _FolderTileState();
}

class _FolderTileState extends State<FolderTile> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final folder = widget.folder;
    final isExpanded = widget.folder.isExpanded;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpacedTile(
          level: widget.level,
          organizer: widget.folder,
          iconData: isExpanded ? Icons.folder_open : Icons.folder,
          iconColor: context.colorScheme.primary,
          onClicked: () {
            context.read<OrganizerProvider>().toggleExpander(widget.folder);
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
