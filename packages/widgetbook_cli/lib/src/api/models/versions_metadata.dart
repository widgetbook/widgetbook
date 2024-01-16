import 'package:file/file.dart';
import 'package:yaml/yaml.dart';

import '../../../metadata.dart';

class VersionsMetadata {
  VersionsMetadata({
    required this.flutter,
    required this.widgetbook,
    required this.cli,
    required this.generator,
    required this.annotation,
  });

  final String? flutter;
  final String? widgetbook;
  final String cli;
  final String? generator;
  final String? annotation;

  /// Creates a [VersionsMetadata] instance from a [lockFile] and the output
  /// of `flutter --version`.
  static Future<VersionsMetadata?> from({
    required File lockFile,
    required String flutterVersionOutput,
  }) async {
    try {
      final versionRegex = RegExp(r'Flutter (\d+.\d+.\d+)');
      final versionMatch = versionRegex.firstMatch(flutterVersionOutput);
      final flutterVersion = versionMatch?.group(1);

      final lockContent = await lockFile.readAsString();
      final lockYaml = loadYaml(lockContent) as YamlMap;

      return VersionsMetadata(
        cli: packageVersion,
        flutter: flutterVersion,
        widgetbook: lockYaml.versionOf('widgetbook'),
        annotation: lockYaml.versionOf('widgetbook_annotation'),
        generator: lockYaml.versionOf('widgetbook_generator'),
      );
    } catch (_) {
      return null;
    }
  }

  Map<String, String> toHeaders() {
    return {
      'x-widgetbook_cli-version': cli,
      if (flutter != null) 'x-flutter-version': flutter!,
      if (widgetbook != null) 'x-widgetbook-version': widgetbook!,
      if (generator != null) 'x-widgetbook_generator-version': generator!,
      if (annotation != null) 'x-widgetbook_annotation-version': annotation!,
    };
  }
}

extension LockFileX on YamlMap {
  YamlMap get packages => this['packages'] as YamlMap;

  String? versionOf(String name) {
    final package = packages[name] as YamlMap?;
    return package?['version']?.toString();
  }
}
