import '../tree/tree_node.dart';
import 'instance.dart';
import 'list_instance.dart';
import 'property.dart';

/// An instance for [WidgetbookFolder]
class WidgetbookFolderInstance extends Instance {
  WidgetbookFolderInstance({
    required TreeNode<String> node,
  }) : super(
          name: 'WidgetbookFolder',
          properties: [
            Property.string(
              key: 'name',
              value: node.data,
            ),
            Property(
              key: 'children',
              instance: ListInstance(
                instances: node.instances,
              ),
            ),
          ],
        );
}
