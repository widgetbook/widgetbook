import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cookbook1/screens/home.dart';
import 'package:cookbook1/screens/login.dart';
import 'package:cookbook1/riverpod/auth_riverpod.dart';

class MockAuthProvider extends Mock implements AuthProvider {}

void main() {
  group('Home Widget Test', () {
    late MockAuthProvider mockAuthProvider;

    setUp(() {
      mockAuthProvider = MockAuthProvider();
    });

    testWidgets('Renders UI elements and logs out',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWithValue(mockAuthProvider),
          ],
          child: const MaterialApp(
            home: Home(),
          ),
        ),
      );

      // Verify the presence of UI elements
      expect(find.text('Home Page'), findsOneWidget);
      expect(find.text('Welcome to Cookbook'), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);

      // Tap the logout button
      await tester.tap(find.byIcon(Icons.logout));
      await tester.pumpAndSettle();

      // Verify that the logout method is called
      verify(mockAuthProvider.logoutUser()).called(1);

      // Verify navigation to the Login screen
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
