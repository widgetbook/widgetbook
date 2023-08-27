import 'package:test/test.dart';
import 'package:widgetbook_generator/code/widgetbook_component_instance.dart';
import 'package:widgetbook_generator/code/widgetbook_folder_instance.dart';
import 'package:widgetbook_generator/code/widgetbook_instance.dart';
import 'package:widgetbook_generator/code/widgetbook_use_case_instance.dart';
import 'package:widgetbook_generator/models/use_case_metadata.dart';
import 'package:widgetbook_generator/tree/tree_node.dart';

import '../../helpers/mock_use_case_metadata.dart';

void main() {
  group('$WidgetbookInstance', () {
    test('fromNode (UseCase)', () {
      final actual = WidgetbookInstance.fromNode(
        TreeNode<UseCaseMetadata>(
          MockUseCaseMetadata(),
        ),
      );

      expect(
        actual.runtimeType,
        WidgetbookUseCaseInstance,
      );
    });

    test('fromNode (Component)', () {
      final actual = WidgetbookInstance.fromNode(
        TreeNode<String>('Component', {
          'Default': TreeNode<UseCaseMetadata>(
            MockUseCaseMetadata(),
          ),
        }),
      );

      expect(
        actual.runtimeType,
        WidgetbookComponentInstance,
      );
    });

    test('fromNode (Folder)', () {
      final actual = WidgetbookInstance.fromNode(
        TreeNode<String>('Folder', {
          'Component': TreeNode<String>('Component'),
        }),
      );

      expect(
        actual.runtimeType,
        WidgetbookFolderInstance,
      );
    });

    test('fromNode (Empty Folder)', () {
      final actual = WidgetbookInstance.fromNode(
        TreeNode<String>('Folder'),
      );

      expect(
        actual.runtimeType,
        WidgetbookFolderInstance,
      );
    });
  });
}
