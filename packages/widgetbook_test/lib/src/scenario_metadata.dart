import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook/widgetbook.dart';

import 'test.dart';

class ScenarioMetadata {
  const ScenarioMetadata({
    required this.component,
    required this.story,
    required this.scenario,
    required this.imageBytes,
  });

  final Component component;
  final Story story;
  final Scenario scenario;
  final Uint8List imageBytes;

  File get imageFile => File(baseFilename('png'));
  File get jsonFile => File(baseFilename('json'));
  Directory get directory => Directory(
    '${outputDir}/${component.name}/${story.name}/',
  );

  String baseFilename(String extension) {
    return '${directory.path}${scenario.name}.$extension';
  }

  String get hash {
    final bytes = imageBytes;
    final buffer = bytes.buffer;
    final digest = sha256.convert(buffer.asUint8List());
    return digest.toString();
  }

  Map<String, dynamic> toJson() {
    final effectiveArgs = scenario.args ?? story.args;
    return {
      'component': {
        'name': component.name,
        'path': component.path,
      },
      'story': {
        'name': story.name,
        'designLink': story.designLink,
      },
      'scenario': {
        'name': scenario.name,
        'modes': scenario.modes?.map((mode) => mode.toQueryGroup()).toList(),
        'args': effectiveArgs.list.map((arg) => arg?.toQueryGroup()).toList(),
      },
      'image': {
        'path': imageFile.path,
        'hash': hash,
      },
    };
  }
}
