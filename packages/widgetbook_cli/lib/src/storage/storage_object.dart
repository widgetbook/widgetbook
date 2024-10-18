import 'package:mime/mime.dart';

class StorageObject {
  StorageObject({
    required String key,
    required this.size,
    required this.reader,
  }) : rawKey = key;

  final String rawKey;
  final int size;
  final Stream<List<int>> Function() reader;

  // Keys need to be in POSIX format in the storage,
  // Since they are derive from paths, that means they can
  // be in Windows format, so we convert them to POSIX format
  String get key => rawKey.replaceAll('\\', '/');

  String get mimeType => lookupMimeType(key) ?? 'application/octet-stream';
}
