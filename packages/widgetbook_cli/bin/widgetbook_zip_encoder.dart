import 'dart:io';

import 'package:archive/archive_io.dart';

import 'parsers/exceptions.dart';

/// Encoder to create the zip file required by Widgetbook Core backend
class WidgetbookZipEncoder {
  /// Encodes the directory to a .zip file
  File? encode(Directory directory) {
    if (directory.existsSync()) {
      const fileName = 'web.zip';
      ZipFileEncoder()
        ..create(fileName)
        ..addDirectory(
          directory,
          includeDirName: false,
        )
        ..close();
      final createdZip = File(fileName);
      if (!createdZip.existsSync()) {
        throw FileNotFoundFailure(
          message: 'File ${createdZip.path} does not exist.',
        );
      }
      return createdZip;
    } else {
      throw DirectoryNotFoundFailure(
        message: 'Directory ${directory.path} does not exist.',
      );
    }
  }
}
