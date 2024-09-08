import 'package:mime/mime.dart';

class StorageObject {
  StorageObject({
    required this.key,
    required this.size,
    required this.reader,
  });

  final String key;
  final int size;
  final Stream<List<int>> Function() reader;

  String get mimeType => lookupMimeType(key) ?? 'application/octet-stream';
}
