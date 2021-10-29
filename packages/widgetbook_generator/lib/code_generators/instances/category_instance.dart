import 'package:widgetbook_generator/code_generators/instances/folder_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widget_element_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/services/tree_service.dart';

class CategoryInstance extends Instance {
  CategoryInstance({
    required String name,
    List<Folder> folders = const <Folder>[],
    List<Widget> widgets = const <Widget>[],
  }) : super(
          name: 'Category',
          properties: [
            Property.string(key: 'name', value: name),
            Property(
              key: 'folders',
              instance: ListInstance(
                instances: folders
                    .map((folder) => FolderInstance(folder: folder))
                    .toList(),
              ),
            ),
            Property(
              key: 'widgets',
              instance: ListInstance(
                instances: widgets
                    .map((widget) => WidgetElementInstance(
                          name: widget.name,
                          stories: widget.stories,
                        ))
                    .toList(),
              ),
            ),
          ],
        );
}
