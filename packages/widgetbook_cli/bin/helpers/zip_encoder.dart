import 'package:archive/archive_io.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';

class ZipEncoder {
  const ZipEncoder({
    this.fileSystem = const LocalFileSystem(),
  });

  final FileSystem fileSystem;

  /// Returns the encoded ZIP file,
  /// or null if file could not be encoded.
  Future<File?> zip(Directory dir) async {
    final filename = '${dir.path}.zip';
    final encoder = ZipFileEncoder();

    encoder.zipDirectory(
      dir,
      filename: filename,
    );

    final file = fileSystem.file(filename);
    final exists = await file.exists();

    return exists ? file : null;
  }
}
