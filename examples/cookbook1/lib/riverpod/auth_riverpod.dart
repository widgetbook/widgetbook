import 'package:cookbook1/services/abstract/firestore_service.dart';
import 'package:cookbook1/services/firebase_auth.dart';
import 'package:cookbook1/services/firestore_data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  UserCredential? _authUserCredential;
  final Map<String, dynamic> _userData = {};
  FirebaseAuthClass authClass = FirebaseAuthClass();
  BaseFirestoreService fstore = FirestoreService();

  // Getter functions
  bool get isLoading => _isLoading;
  UserCredential? get authUserCredential => _authUserCredential;
  Map<String, dynamic> get userData => _userData;

  Future<UserCredential?> loginUserWithFirebase(
      String email, String password) async {
    setLoader(true);

    try {
      _authUserCredential =
          await authClass.loginUserWithFirebase(email, password);
      setLoader(false);
      notifyListeners();
      return _authUserCredential;
    } catch (e) {
      setLoader(false);
      return Future.error(e);
    }
  }

  Future<UserCredential?> signUpUserWithFirebase(
    String email,
    String password,
    String name,
  ) async {
    var isSuccess = false;
    setLoader(true);

    _authUserCredential =
        await authClass.signUpUserWithFirebase(email, password, name);

    final data = {
      'email': email,
      'password': password,
      'uid': _authUserCredential!.user!.uid,
      'createdAt': DateTime.now().microsecondsSinceEpoch.toString(),
      'name': name
    };

    String userid = _authUserCredential!.user!.uid;
    isSuccess = await addUserToDatabase(data, 'user', userid);
    if (isSuccess) {
      return _authUserCredential!;
    } else {
      throw Exception("error while signup the user");
    }
  }

  Future<bool> addUserToDatabase(
      Map<String, dynamic> data, String collectionName, String docName) async {
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

  setLoader(bool bool) {
    _isLoading = true;
    notifyListeners();
  }
}

final authProvider =
    ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());
