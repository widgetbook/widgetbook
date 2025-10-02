import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook/widgetbook.dart';

import 'test.dart';

class ScenarioMetadata {
  const ScenarioMetadata({
    required this.scenario,
    required this.imageBytes,
    required this.imageWidth,
    required this.imageHeight,
    required this.pixelRatio,
  });

  final Scenario scenario;
  final Uint8List imageBytes;
  final int imageWidth;
  final int imageHeight;
  final double pixelRatio;

  Component get component => scenario.story.component;
  Story get story => scenario.story;

  File get imageFile => File(baseFilename('png'));
  File get jsonFile => File(baseFilename('json'));
  Directory get directory => Directory(
    '${outputDir}/${component.name}/${story.name}/',
  );

  String get hash {
    final bytes = imageBytes;
    final buffer = bytes.buffer;
    final digest = sha256.convert(buffer.asUint8List());
    return digest.toString();
  }

  String baseFilename(String extension) {
    return '${directory.path}${scenario.name}.$extension';
  }

  Map<String, dynamic> toJson() {
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
        'modes': scenario.modes.map((mode) => mode.toQueryGroup()).toList(),
        'args': scenario.args.list.map((arg) => arg?.toQueryGroup()).toList(),
      },
      'image': {
        'path': imageFile.path,
        'hash': hash,
        'width': imageWidth,
        'height': imageHeight,
        'pixelRatio': pixelRatio,
        'size': imageBytes.length,
      },
    };
  }
}
