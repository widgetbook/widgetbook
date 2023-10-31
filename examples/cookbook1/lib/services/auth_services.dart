import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServicesProvider = Provider<AuthServices>((ref) {
  return AuthServices();
});

class AuthServices {
  bool isLogin = false;

  Future<bool> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2), () {
      isLogin = true;
    });

    return isLogin;
  }

  Future<bool> logout() async {
    await Future.delayed(const Duration(seconds: 2));
    () {
      isLogin = false;
    };
    return true;
  }
}
