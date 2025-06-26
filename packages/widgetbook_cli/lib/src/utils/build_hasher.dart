import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:file/file.dart';

import '../../widgetbook_cli.dart';

class BuildHasher {
  const BuildHasher();

  /// Generates a hash for a widgetbook build based on:
  ///
  /// [1] The `RESOURCES` map in `flutter_service_worker.js`.
  /// This map has a content-hash for each file in the build.
  /// See more:
  /// - https://github.com/flutter/flutter/blob/master/packages/flutter_tools/lib/src/web/file_generators/flutter_service_worker_js.dart#L42-L71
  /// - https://github.com/flutter/flutter/blob/master/packages/flutter_tools/flutter_tools/lib/src/build_system/targets/web.dart#L747-L748
  ///
  /// [2] The widgetbook [CacheStore]. Since annotations do not affect the
  /// `main.dart.js` file, then we need to put them into account when
  /// calculating the hash. So when a user adds, removed or modifies
  /// a knobs/addons config, the hash will change.
  Future<String?> convert(Directory buildDir, CacheStore cache) async {
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

    // It is not guaranteed that the [CacheStore] reads the use-cases metadata
    // in the same order each time, so we need to sort them to ensure
    // that the hash is deterministic across runs.
    final sortedUseCasesJson = cache.useCases
        .sortedBy((x) => '${x.navPath}/${x.componentName}${x.useCaseName}')
        .map((x) => x.toCloudUseCase())
        .toList();

    final encodedUseCases = utf8.encode(
      jsonEncode(sortedUseCasesJson),
    );

    final encodedAddonsConfigs = utf8.encode(
      jsonEncode(cache.addonsConfigs ?? {}),
    );

    return md5.convert([
      ...encodedResources,
      ...encodedUseCases,
      ...encodedAddonsConfigs,
    ]).toString();
  }
}
