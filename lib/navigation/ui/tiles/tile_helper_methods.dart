import 'package:flutter/material.dart';
import 'package:widgetbook/models/organizers/organizers.dart';
import 'package:widgetbook/navigation/ui/tiles/folder_tile.dart';
import 'package:widgetbook/navigation/ui/tiles/widget_tile.dart';

List<Widget> buildFolders({
  required List<Folder> folders,
  required int currentLevel,
}) {
  return folders
      .map(
        (Folder folder) => FolderTile(
          folder: folder,
          level: currentLevel,
        ),
      )
      .toList();
}

List<Widget> buildWidgets({
  required List<WidgetElement> widgets,
  required int currentLevel,
}) {
  return widgets
      .map(
        (WidgetElement widgetElement) => WidgetTile(
          widgetElement: widgetElement,
          level: currentLevel,
        ),
      )
      .toList();
}
