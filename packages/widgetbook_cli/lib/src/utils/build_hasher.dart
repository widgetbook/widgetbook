import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:file/file.dart';

class BuildHasher {
  const BuildHasher();

  /// Generates a hash for a web build.
  /// The hash is generated based on the `RESOURCES` map in `flutter_service_worker.js`.
  /// This map has a content-hash for each file in the build.
  /// See more:
  /// 1. https://github.com/flutter/flutter/blob/master/packages/flutter_tools/lib/src/web/file_generators/flutter_service_worker_js.dart#L42-L71
  /// 2. https://github.com/flutter/flutter/blob/master/packages/flutter_tools/flutter_tools/lib/src/build_system/targets/web.dart#L747-L748
  Future<String?> convert(Directory buildDir) async {
    final serviceWorkerFile = buildDir.childFile('flutter_service_worker.js');
    if (!serviceWorkerFile.existsSync()) return null;

    final content = await serviceWorkerFile.readAsString();
    final resourcesVariable = RegExp(
      r'const RESOURCES = ({.*?});',
      dotAll: true,
    ).firstMatch(content);

    final resourcesMap = resourcesVariable?.group(1);
    if (resourcesMap == null) return null;

    // These are keys that are indeterministic
    // and change from one build to another.
    // We exclude them from the hash calculation.
    const excludedKeys = [
      'flutter_bootstrap.js', // `serviceWorkerVersion` changes on every build.
    ];

    final resourcesJson = jsonDecode(resourcesMap) as Map<String, dynamic>;
    resourcesJson.removeWhere(
      (key, value) => excludedKeys.contains(key),
    );

    final encodedResources = utf8.encode(jsonEncode(resourcesJson));

    return md5.convert(encodedResources).toString();
  }
}
