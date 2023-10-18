import 'dart:io';

import 'package:test/test.dart';
import 'package:widgetbook_cli/widgetbook_cli.dart';

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

    test('valid name', () {
      final pubName = getYamlValue('name');

      expect(
        packageName,
        equals(pubName),
      );
    });
  });
}
