import 'package:archive/archive_io.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path/path.dart' as p;

class ZipEncoder {
  const ZipEncoder({
    this.fileSystem = const LocalFileSystem(),
  });

  final FileSystem fileSystem;

  /// Returns the encoded ZIP file,
  /// or null if file could not be encoded.
  Future<File?> zip(Directory dir, String filename) async {
    final encoder = ZipFileEncoder();
    final parentDir = fileSystem.directory(dir.parent.path);
    final relativeFilename = p.join(parentDir.path, filename);

    encoder.zipDirectory(
      dir,
      filename: relativeFilename,
    );

    final file = fileSystem.file(relativeFilename);
    final exists = await file.exists();

    return exists ? file : null;
  }
}
