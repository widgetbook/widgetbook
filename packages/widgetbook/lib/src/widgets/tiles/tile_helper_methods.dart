import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/organizers/organizers.dart';
import 'package:widgetbook/src/widgets/tiles/folder_tile.dart';
import 'package:widgetbook/src/widgets/tiles/widget_tile.dart';

List<Widget> buildFolders({
  required List<WidgetbookFolder> folders,
  required int currentLevel,
}) {
  return folders
      .map(
        (WidgetbookFolder folder) => FolderTile(
          folder: folder,
          level: currentLevel,
        ),
      )
      .toList();
}

List<Widget> buildWidgets({
  required List<WidgetbookComponent> widgets,
  required int currentLevel,
}) {
  return widgets
      .map(
        (WidgetbookComponent widgetElement) => WidgetTile(
          widgetElement: widgetElement,
          level: currentLevel,
        ),
      )
      .toList();
}
