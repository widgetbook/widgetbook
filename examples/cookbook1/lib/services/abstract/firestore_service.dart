abstract class BaseFirestoreService {
  Future addDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName);

      Future updateDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName);

      Future getUserDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName);

}
