import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widget_element_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/services/tree_service.dart';

class FolderInstance extends Instance {
  FolderInstance({required Folder folder})
      : super(
          name: 'Folder',
          properties: [
            Property.string(key: 'name', value: folder.name),
            Property(
              key: 'widgets',
              instance: ListInstance<WidgetElementInstance>(
                instances: folder.widgets.values
                    .map(
                      (widget) => WidgetElementInstance(
                        name: widget.name,
                        stories: widget.stories,
                      ),
                    )
                    .toList(),
              ),
            ),
            Property(
              key: 'folders',
              instance: ListInstance<FolderInstance>(
                instances: folder.subFolders.values
                    .map((folder) => FolderInstance(folder: folder))
                    .toList(),
              ),
            ),
          ],
        );
}
