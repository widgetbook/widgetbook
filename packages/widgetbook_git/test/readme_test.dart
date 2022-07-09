import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('readme example contents', () {
    final readmeContent = File('README.md').readAsStringSync();
    final exampleContent = File('example/example.dart').readAsStringSync();

    expect(readmeContent, contains(exampleContent));
  });
}
