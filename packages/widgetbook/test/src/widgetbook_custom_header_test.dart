import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group('Widgetbook with custom header', () {
    testWidgets(
      'when header is provided, '
      'then it is passed to the WidgetbookState',
      (tester) async {
        // Create a simple custom header
        final header = Container(
          padding: const EdgeInsets.all(8),
          color: Colors.blue.shade100,
          child: const Text('My Design System'),
        );

        // Create a key to find the Widgetbook widget
        final widgetbookKey = GlobalKey();

        await tester.pumpWidget(
          Widgetbook.material(
            key: widgetbookKey,
            directories: [
              WidgetbookComponent(
                name: 'Test Component',
                useCases: [
                  WidgetbookUseCase(
                    name: 'Test Use Case',
                    builder: (context) => const SizedBox(),
                  ),
                ],
              ),
            ],
            header: header,
          ),
        );

        // Wait for the widget tree to settle
        await tester.pumpAndSettle();

        // Verify the custom header is passed to the Widgetbook
        final widgetbookState =
            (widgetbookKey.currentState as State).widget as Widgetbook;
        expect(widgetbookState.header, equals(header));
      },
    );
  });
}
