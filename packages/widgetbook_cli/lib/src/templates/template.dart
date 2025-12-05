import 'dart:io';

abstract class Template {
  Template(this.filename, this.content);

  final String filename;
  final String content;

  Future<void> create(String dir) async {
    final file = File('${dir}/${filename}');
    await file.create(recursive: true);
    await file.writeAsString(content);
  }
}
