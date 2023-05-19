import '../generators/tree_service.dart';
import 'instance.dart';
import 'list_instance.dart';
import 'property.dart';
import 'widgetbook_folder_instance.dart';
import 'widgetbook_widget_instance.dart';

/// An instance for Category
class WidgetbookCategoryInstance extends Instance {
  /// Creates a new instance of [WidgetbookCategoryInstance]
  WidgetbookCategoryInstance({
    required String name,
    List<Folder> folders = const <Folder>[],
    List<Widget> widgets = const <Widget>[],
  }) : super(
          name: 'WidgetbookCategory',
          properties: [
            Property.string(key: 'name', value: name),
            Property(
              key: 'children',
              instance: ListInstance(
                instances: [
                  ...folders.map(
                    (folder) => WidgetbookFolderInstance(folder: folder),
                  ),
                  ...widgets.map(
                    (widget) => WidgetbookComponentInstance(
                      name: widget.name,
                      stories: widget.stories,
                      isExpanded: widget.isExpanded,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
}
