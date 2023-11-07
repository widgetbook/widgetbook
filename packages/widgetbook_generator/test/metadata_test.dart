import 'dart:io';

import 'package:test/test.dart';
import 'package:widgetbook_generator/metadata.dart';

void main() {
  final file = File('pubspec.yaml');
  final lines = file.readAsLinesSync();

  String getYamlValue(String key) {
    final line = lines.firstWhere((x) => x.contains(key));
    return line.split(':').last.trim();
  }

  group('metadata', () {
    test('valid version', () {
      final pubVersion = getYamlValue('version');

      expect(
        packageVersion,
        equals(pubVersion),
      );
    });
  });
}
