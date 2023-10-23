import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook1/model/user_model.dart';
import 'package:cookbook1/services/abstract/firestore_service.dart';

class FirestoreService extends BaseFirestoreService {
  final _firestoreInstance = FirebaseFirestore.instance;

  @override
  Future addDataToFirestore(
    DataModel data,
    String collectionName,
    String docName,
  ) async {
    try {
      await _firestoreInstance
          .collection(collectionName)
          .withConverter(
            fromFirestore: (snapshot, _) =>
                DataModel.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .doc(docName)
          .set(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future updateDataToFirestore(
    DataModel data,
    String collectionName,
    String docName,
  ) async {
    try {} catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future getUserDataToFirestore(
    DataModel data,
    String collectionName,
    String docName,
  ) async {
    try {
      final userData = await _firestoreInstance
          .collection(collectionName)
          .doc(docName)
          .get();

      return userData.data();
    } catch (e) {
      throw Exception(e);
    }
  }
}
