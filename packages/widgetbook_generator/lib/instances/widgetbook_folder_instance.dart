import '../generators/tree_service.dart';
import 'instance.dart';
import 'list_instance.dart';
import 'property.dart';
import 'widgetbook_widget_instance.dart';

/// Defines an instance to create code for a [Folder]
class WidgetbookFolderInstance extends Instance {
  /// Creates a new instance of [WidgetbookFolderInstance]
  WidgetbookFolderInstance({
    required Folder folder,
  }) : super(
          name: 'WidgetbookFolder',
          properties: [
            Property.string(key: 'name', value: folder.name),
            Property(
              key: 'children',
              instance: ListInstance(
                instances: [
                  ...folder.widgets.values.map(
                    (widget) => WidgetbookComponentInstance(
                      name: widget.name,
                      stories: widget.stories,
                    ),
                  ),
                  ...folder.subFolders.values.map(
                    (folder) => WidgetbookFolderInstance(folder: folder),
                  ),
                ],
              ),
            ),
          ],
        );
}
