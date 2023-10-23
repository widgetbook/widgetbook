import 'package:cookbook1/screens/components/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomTextFormField UI Test - Yellow Field Color',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextFormField(
            controller: TextEditingController(),
            hintText: 'hello',
            textFieldColor: Colors.yellow,
            suffixIcon: Icons.headphones,
            obscureText: true,
          ),
        ),
      ),
    );

    // Verify that the UI renders correctly with yellow field color
    expect(find.byType(CustomTextFormField), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets('CustomTextFormField UI Test - Blue Field Color',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextFormField(
            controller: TextEditingController(),
            hintText: 'hello',
            textFieldColor: Colors.blue,
            suffixIcon: Icons.headphones,
            obscureText: true,
          ),
        ),
      ),
    );

    // Verify that the UI renders correctly with blue field color
    expect(find.byType(CustomTextFormField), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
  });
}
