import 'package:cookbook1/notifier/auth_notifier.dart';
import 'package:cookbook1/screens/components/custom_form.dart';
import 'package:cookbook1/screens/components/custom_image.dart';
import 'package:cookbook1/screens/components/custom_title_text.dart';
import 'package:cookbook1/screens/home.dart';
import 'package:cookbook1/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthProvider extends Mock implements AuthNotifer {}

void main() {
  //  final mockObserver = MockNavigatorObserver();
  late MockAuthProvider mockAuthProvider;
  setUp(() {
    mockAuthProvider = MockAuthProvider();
  });
  testWidgets('LoginPage UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ProviderScope(
          overrides: [
            authNotierProvider.overrideWith((ref) => mockAuthProvider),
          ],
          child: LoginPage(),
        ),
      ),
    );

    // Verify that the app bar is rendered with the correct title.
    expect(find.text("LoginPage"), findsOneWidget);

    // Verify that the welcome text is rendered.
    expect(find.text("Welcome to Cookbook"), findsOneWidget);

    // Verify that the CustomImage widget is rendered.
    expect(find.byType(CustomImage), findsOneWidget);

    // Verify that the login form is rendered.
    expect(find.byType(LoginForm), findsOneWidget);

    // Mock user input (enter email and password).
    await tester.enterText(find.byType(TextField).first, 'test@email.com');
    await tester.enterText(find.byType(TextField).last, 'testPassword');

    // Tap the login button.
    await tester.tap(find.text("Login"));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authNotierProvider.overrideWith((ref) => mockAuthProvider)],
        child: const MaterialApp(home: Home()),
      ),
    );
  });
}
