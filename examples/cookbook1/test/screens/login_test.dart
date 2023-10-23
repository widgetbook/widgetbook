import 'package:cookbook1/screens/components/custom_button.dart';
import 'package:cookbook1/screens/components/custom_form.dart';
import 'package:cookbook1/screens/components/custom_textform_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cookbook1/screens/login.dart';
import 'package:cookbook1/screens/signup.dart';
import 'package:cookbook1/screens/home.dart';
import 'package:mockito/mockito.dart'; // Import Mockito for mocking
import 'package:cookbook1/riverpod/auth_riverpod.dart'; // Import the auth provider
import 'package:cookbook1/screens/components/custom_image.dart';
import 'package:cookbook1/screens/components/custom_title_text.dart';

class MockAuthProvider extends Mock implements AuthProvider {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  group('LoginPage Widget Test', () {
    late MockAuthProvider mockAuthProvider;
    late MockUserCredential mockUserCredential;
    late MockUser mockUser;

    setUp(() {
      mockAuthProvider = MockAuthProvider();
      mockUser = MockUser();
      mockUserCredential = MockUserCredential();
    });

    testWidgets('Renders UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWithValue(mockAuthProvider),
          ],
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Verify the presence of UI elements
      expect(find.text('LoginPage'), findsOneWidget);
      expect(find.byType(CustomImage), findsOneWidget);
      expect(find.byType(CustomTitleText), findsOneWidget);
      expect(find.byType(LoginForm), findsOneWidget);
    });

    testWidgets('Login Process', (WidgetTester tester) async {
      when(mockUserCredential.user).thenReturn(mockUser);
      when(
        mockAuthProvider.loginUserWithFirebase(
          'john.doe@example.com',
          'password123',
        ),
      ).thenAnswer((_) => Future.value(mockUserCredential));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWithValue(mockAuthProvider),
          ],
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      await tester.enterText(
        // ignore: require_trailing_commas
        find.byKey(const Key('emailTextField1')),
        'john.doe@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('passwordTextField1')),
        'password123',
      );

      // expect(find.byKey(Key('LoginButton1')), findsOneWidget);
      // Tap the Login button
      await tester.tap(find.byType(CustomButton), warnIfMissed: false);
      await tester.pump();

      //Verify that the authentication method is called
      verify(
        mockAuthProvider.loginUserWithFirebase(
          'john.doe@example.com',
          'password123',
        ),
      ).called(1);

      // Verify navigation to the Home screen
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('Navigate to SignUp Screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWithValue(mockAuthProvider),
          ],
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Tap the Sign Up button
      print(find.byKey(const Key("SignUpButtonNewUser")).first);
      await tester.tap(find.byKey(const Key("SignUpButtonNewUser")).first,
          warnIfMissed: false);
      await tester.pump();

      // Verify navigation to the SignUp screen
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
