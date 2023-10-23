import 'package:cookbook1/model/user_model.dart';

abstract class BaseFirestoreService {
  Future addDataToFirestore(
    DataModel data,
    String collectionName,
    String docName,
  );

  Future updateDataToFirestore(
    DataModel data,
    String collectionName,
    String docName,
  );

  Future getUserDataToFirestore(
    DataModel data,
    String collectionName,
    String docName,
  );
}
