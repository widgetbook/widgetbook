import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cookbook1/services/abstract/firestore_service.dart';


class FirestoreService extends BaseFirestoreService {
  final _firestoreInstance = FirebaseFirestore.instance;
  @override
  Future addDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async {
    try {
      
      await _firestoreInstance
          .collection(collectionName)
          .doc(docName)
          .set(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future updateDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async{
    try{
       final userData = await _firestoreInstance
          .collection(collectionName)
          .doc(docName)
          .update(data)
          .then((value) => print("userData is updated"))
          .catchError((error)=>print("error while updating data $error"));

    }
    catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future getUserDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async {
    try {
      final userData = await _firestoreInstance
          .collection(collectionName)
          .doc(docName)
          .get();
    } catch (e) {
      throw Exception(e);
    }
   
  }
}



