import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_folder_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_widget_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/services/tree_service.dart';

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
