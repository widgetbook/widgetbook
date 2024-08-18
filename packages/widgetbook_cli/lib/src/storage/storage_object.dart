import 'package:mime/mime.dart';

class StorageObject {
  StorageObject({
    required this.key,
    required this.size,
    required this.data,
  });

  final String key;
  final int size;
  final Stream<List<int>> data;

  String get mimeType => lookupMimeType(key) ?? 'application/octet-stream';
}
