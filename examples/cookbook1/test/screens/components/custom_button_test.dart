import 'package:cookbook1/screens/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomButton UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            buttonTitle: 'Login',
            onPressed: () {},
            buttonbackColor: const Color.fromARGB(255, 242, 244, 246), // Choose any color for testing
          ),
        ),
      ),
    );

    // Verify that the UI renders correctly
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);

    // Simulate tapping the button
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();
  });
  testWidgets('CustomButton UI Test - blue button ', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            buttonTitle: 'Login',
            onPressed: () {},
            buttonbackColor: Color.fromARGB(255, 9, 50, 183), // Choose any color for testing
          ),
        ),
      ),
    );

    // Verify that the UI renders correctly
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);

    // Simulate tapping the button
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();
  });
  
}
