import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/ui/tiles/category_tile.dart';
import 'package:widgetbook/src/models/organizers/category.dart';

void main() {
  testWidgets('Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CategoryTile(
          category: Category(
            name: 'Test',
          ),
        ),
      ),
    );
  });
}
