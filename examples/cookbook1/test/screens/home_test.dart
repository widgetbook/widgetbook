import 'package:cookbook1/notifier/auth_notifier.dart';
import 'package:cookbook1/screens/home.dart';
import 'package:cookbook1/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockAuthProvider extends Mock implements AuthNotifer {}

void main() {
  final mockObserver = MockNavigatorObserver();
  late MockAuthProvider mockAuthProvider;
  setUp(() {
    mockAuthProvider = MockAuthProvider();
  });
  testWidgets('Home Screen UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ProviderScope(
          overrides: [
            authNotierProvider.overrideWith((ref) => mockAuthProvider)
          ],
          child: const Home(),
        ),
        navigatorObservers: [mockObserver],
      ),
    );

    // Verify that the app bar is rendered with the correct title.
    expect(find.text("Home Page"), findsOneWidget);

    // Verify that the welcome text is rendered.
    expect(find.text("Welcome to Cookbook"), findsOneWidget);

    // Verify that the logout button is rendered.
    expect(find.byIcon(Icons.logout), findsOneWidget);

    // // Tap the logout button.
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authNotierProvider.overrideWith((ref) => mockAuthProvider)],
        child: const MaterialApp(home: Home()),
      ),
    );
  });
}

void verifyLogoutBehavior(WidgetTester tester) async {
  // You can use tester methods to verify specific behavior after the logout button is pressed.
  // For example, checking if the LoginPage is navigated to.
  expect(find.text("Welcome to Cookbook"), findsNothing);
  expect(find.byType(LoginPage), findsOneWidget);

  // Add more assertions based on your specific application behavior.
}
