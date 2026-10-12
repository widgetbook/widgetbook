import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/navigation/navigation.dart';

import '../../helper/helper.dart';

void main() {
  group('$CategoryTreeTile', () {
    testWidgets(
      'given a name longer than the available width, '
      'then the name is truncated to a single line at a fixed height',
      (tester) async {
        const name = 'a category name that is far too long to fit';

        await tester.pumpWidgetWithMaterialApp(
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 120,
              child: CategoryTreeTile(
                node: TreeNode<Null>('[$name]', null, null),
              ),
            ),
          ),
        );

        final text = tester.widget<Text>(find.text(name.toUpperCase()));

        expect(tester.takeException(), isNull);
        expect(text.maxLines, equals(1));
        expect(text.overflow, equals(TextOverflow.ellipsis));
        expect(
          tester.getSize(find.byType(CategoryTreeTile)).height,
          equals(CategoryTreeTile.height),
        );
      },
    );
  });
}
