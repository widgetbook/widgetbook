import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../tree_root.dart';

void main() {
  group(
    '$WidgetbookNode',
    () {
      test(
        'given a use-case node, '
        'when [isLeaf] is called, '
        'then the result is true',
        () {
          final node = WidgetbookUseCase(
            name: 'Use Case',
            builder: (_) => Container(),
          );

          expect(node.isLeaf, isTrue);
        },
      );

      test(
        'given a root node, '
        'when [isLeaf] is called, '
        'then the result is false',
        () {
          expect(treeRoot.isLeaf, isFalse);
        },
      );

      test(
        'when correct filter is applied, '
        'then only the children that match the filter exist in the result',
        () {
          final result = treeRoot.filter((node) => node.name.contains('1'));

          expect(result!.children!.length, 1);
        },
      );

      test(
        'when wrong filter is applied, '
        'then null is returned',
        () {
          final result = treeRoot.filter((node) => node.name.contains('3'));

          expect(result, isNull);
        },
      );

      test(
        'when correct find is applied, '
        'then the first matching node is returned',
        () {
          final result = treeRoot.find((node) => node.name.contains('1'));

          expect(result!.name, 'Folder 1');
        },
      );

      test(
        'when wrong find is applied, '
        'then null is returned',
        () {
          final result = treeRoot.find((node) => node.name.contains('3'));

          expect(result, isNull);
        },
      );

      test(
        'given a tree, '
        'then the leaves length is correct',
        () {
          final result = treeRoot.leaves;

          expect(result.length, 3);
        },
      );

      test(
        'given a leaf node, '
        'then the path is correct',
        () {
          final result = treeRoot.leaves.first;

          expect(result.path, 'folder-1/component-1/use-case-1');
        },
      );

      test(
        'given a root node, '
        'then the count is correct',
        () {
          expect(treeRoot.count, 8);
        },
      );
    },
  );
}
