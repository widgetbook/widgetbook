import 'package:cookbook1/screens/home.dart';
import 'package:cookbook1/screens/login.dart'; // Import your login screen file
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cookbook1/services/auth_services.dart';

final authNotierProvider = StateNotifierProvider<AuthNotifer, bool>((ref) {
  return AuthNotifer(ref.watch(authServicesProvider));
});

class AuthNotifer extends StateNotifier<bool> {
  final AuthServices _authServices;
  AuthNotifer(this._authServices) : super(false);

  login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      state = true;
      await _authServices
          .login(
        email: email,
        password: password, // Fix: use the correct parameter
      )
          .then((value) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Home()),
        );
        state = false;
      });
    } catch (e) {
      state = false;
      rethrow;
    }
  }

  logout(BuildContext context) {
    _authServices.logout(); // Call your logout method from AuthServices
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
// Navigate to the login screen
  }
}
