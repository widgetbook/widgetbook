import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseFirebaseService {
  Future<UserCredential> loginUserWithFirebase(String email, String password);
  Future<UserCredential> signUpUserWithFirebase(String email, String password,String name);
  void signOut();
  bool isUserLoggedIn();
}
