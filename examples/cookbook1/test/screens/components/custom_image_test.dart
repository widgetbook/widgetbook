import 'package:cookbook1/screens/components/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomImage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomImage(
            height: 300,
            width: 300,
          ),
        ),
      ),
    );

    // Verify that the UI renders correctly
    expect(find.byType(CustomImage), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('CustomImage Small Size UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomImage(
            height: 100,
            width: 100,
          ),
        ),
      ),
    );

    // Verify that the UI renders correctly with small size
    expect(find.byType(CustomImage), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
