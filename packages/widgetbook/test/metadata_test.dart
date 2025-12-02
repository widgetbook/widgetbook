import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/metadata.dart';

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
        kWidgetbookVersion,
        equals(pubVersion),
      );
    });
  });
}
