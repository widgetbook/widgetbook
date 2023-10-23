import 'package:cookbook1/screens/components/custom_button.dart';
import 'package:cookbook1/screens/components/custom_form.dart';
import 'package:cookbook1/screens/components/custom_textform_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginForm UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: LoginForm(
              buttonTitle: "Login",
              emailController: TextEditingController(),
              passController: TextEditingController(),
              onPressed: () {},
              formAssetColor: const Color.fromARGB(255, 245, 246, 247),
              onTap: () {}, // Choose any color for testing
            ),
          ),
        ),
      ),
    );

    // Verify that the UI renders correctly
    expect(find.byType(LoginForm), findsOneWidget);
    expect(find.byType(CustomTextFormField), findsNWidgets(2));
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.text('New user? Sign Up'), findsOneWidget);

    // Simulate tapping the "Login" button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('New user? Sign Up'));
    await tester.pumpAndSettle();
  });
  testWidgets('LoginForm UI Test - Grey color', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                LoginForm(
                  buttonTitle: "Login",
                  emailController: TextEditingController(),
                  passController: TextEditingController(),
                  onPressed: () {},
                  formAssetColor: Color.fromARGB(255, 113, 114, 115),
                  onTap: () {}, // Choose any color for testing
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Verify that the UI renders correctly
    expect(find.byType(LoginForm), findsOneWidget);
    expect(find.byType(CustomTextFormField), findsNWidgets(2));
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.text('New user? Sign Up'), findsOneWidget);

    // Simulate tapping the "Login" button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('New user? Sign Up'));
    await tester.pumpAndSettle();
  });
}
