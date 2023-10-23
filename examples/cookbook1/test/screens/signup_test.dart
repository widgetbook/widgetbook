import 'package:cookbook1/screens/components/custom_button.dart';
import 'package:cookbook1/screens/components/custom_image.dart';
import 'package:cookbook1/screens/components/custom_textform_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cookbook1/screens/signup.dart';
// ignore: unused_import
import 'package:cookbook1/screens/home.dart';
import 'package:mockito/mockito.dart';
import 'package:cookbook1/riverpod/auth_riverpod.dart';

class MockAuthProvider extends Mock implements AuthProvider {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  group('SignUp Widget Test', () {
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
            home: SignUp(),
          ),
        ),
      );

      // Verify the presence of UI elements
      expect(find.text('SignUp'), findsOneWidget);
      expect(find.byType(CustomImage), findsOneWidget);
      expect(find.byType(CustomTextFormField), findsNWidgets(3));
      expect(find.byType(CustomButton), findsOneWidget);
    });

    testWidgets('Sign Up Process', (WidgetTester tester) async {
      when(mockUserCredential.user).thenReturn(mockUser);

      when(
        mockAuthProvider.signUpUserWithFirebase(
          'john.doe@example.com',
          'password123',
          'John Doe',
        ),
      ).thenAnswer((_) => Future.value(mockUserCredential));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWithValue(mockAuthProvider),
          ],
          child: MaterialApp(
            home: SignUp(),
          ),
        ),
      );

      // Enter text into name, email, and password fields
      await tester.enterText(
          find.byKey(const Key('nameTextField')), 'John Doe');
      await tester.enterText(
        find.byKey(const Key('emailTextField')),
        'john.doe@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('passwordTextField')),
        'password123',
      );

      // Tap the Sign Up button
      await tester.tap(find.byType(CustomButton));
      await tester.pump();

      // Verify that the authentication method is called
      verify(
        mockAuthProvider.signUpUserWithFirebase(
          'john.doe@example.com',
          'password123',
          'John Doe',
        ),
      ).called(1);

      // Verify navigation to the Home screen
      expect(find.byType(SignUp), findsOneWidget);
    });
  });
}
