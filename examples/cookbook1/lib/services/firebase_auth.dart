import 'package:cookbook1/services/abstract/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthClass extends BaseFirebaseService {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  bool isUserLoggedIn() {
    if (auth.currentUser != null) {
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Future<UserCredential> loginUserWithFirebase(String email, String password) {
    final loginCredential =
        auth.signInWithEmailAndPassword(email: email, password: password);
    return loginCredential;
  }

  @override
  void signOut() {
    auth.signOut();
  }

  @override
  Future<UserCredential> signUpUserWithFirebase(String email, String password, String name) {
    final userCredential =
        auth.createUserWithEmailAndPassword(email: email, password: password,);

    return userCredential;
  }
}
