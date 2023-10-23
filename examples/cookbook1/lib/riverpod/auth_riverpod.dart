import 'package:cookbook1/model/user_model.dart';
import 'package:cookbook1/services/abstract/firestore_service.dart';
import 'package:cookbook1/services/firebase_auth.dart';
import 'package:cookbook1/services/firestore_data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider {
  UserCredential? _authUserCredential;
  final Map<String, dynamic> _userData = {};
  FirebaseAuthClass authClass = FirebaseAuthClass();
  BaseFirestoreService fstore = FirestoreService();

  UserCredential? get authUserCredential => _authUserCredential;
  Map<String, dynamic> get userData => _userData;

   loginUserWithFirebase(
    String email,
    String password,
  ) async {
    try {
      _authUserCredential =
          await authClass.loginUserWithFirebase(email, password);

      return _authUserCredential;
    } catch (e) {
      return Future.error(e);
    }
  }

 signUpUserWithFirebase(
    String email,
    String password,
    String name,
  ) async {
    var isSuccess = false;

    _authUserCredential =
        await authClass.signUpUserWithFirebase(email, password, name);

    final DataModel dataModel = DataModel(
      name: name,
      email: email,
      uid: _authUserCredential!.user!.uid,
    );

    String userid = _authUserCredential!.user!.uid;
    isSuccess = await addUserToDatabase(dataModel, 'user', userid);
    if (isSuccess) {
      return _authUserCredential!;
    } else {
      throw Exception("error while signup the user");
    }
  }

  Future<bool> addUserToDatabase(
    DataModel data,
    String collectionName,
    String docName,
  ) async {
    var value = false;

    try {
      await fstore.addDataToFirestore(data, collectionName, docName);
      value = true;
    } catch (e) {
      value = false;
    }
    return value;
  }

  void logoutUser() {
    authClass.signOut();
  }
}

final authProvider = Provider<AuthProvider>((ref) => AuthProvider());

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final authStateProvider =
    StreamProvider((ref) => ref.watch(firebaseAuthProvider).authStateChanges());
