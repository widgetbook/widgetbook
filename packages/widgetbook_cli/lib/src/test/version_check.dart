import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

import '../core/cli_exception.dart';
import 'test_exit_codes.dart';

/// The first `widgetbook` version that reads the `WIDGETBOOK_SNAPSHOTS`
/// define in `testWidgetbook`.
final minSnapshotsDefineVersion = Version.parse('4.0.0-beta.16');

/// Throws if the `widgetbook` version resolved for the project at
/// [projectDir] is older than [minVersion], as the CLI is installed globally
/// and a newer flag would otherwise be silently ignored.
///
/// The `pubspec.lock` is looked up from [projectDir] upwards, as packages of
/// a pub workspace share the lock file of the workspace root. A `path`
/// dependency is not checked, as its version is not bumped before a release.
void checkWidgetbookVersion({
  required String projectDir,
  required String flag,
  required Version minVersion,
}) {
  final locked = resolveLockedWidgetbook(projectDir);
  if (locked == null) {
    throw CliException(
      'Could not find the widgetbook version in pubspec.lock; '
      'run flutter pub get first.',
      TestExitCodes.unsupportedVersion,
    );
  }

  final (:version, :source) = locked;
  if (source == 'path') return;

  if (version < minVersion) {
    throw CliException(
      '$flag requires widgetbook >= $minVersion (found $version)',
      TestExitCodes.unsupportedVersion,
    );
  }
}

/// The `widgetbook` version and source in the nearest `pubspec.lock` at or
/// above [projectDir], or `null` if there is none.
({Version version, String? source})? resolveLockedWidgetbook(
  String projectDir,
) {
  var dir = p.normalize(p.absolute(projectDir));
  while (true) {
    final lockFile = File(p.join(dir, 'pubspec.lock'));
    if (lockFile.existsSync()) {
      final lock = loadYaml(lockFile.readAsStringSync());
      return switch (lock) {
        {
          'packages': {
            'widgetbook': {'version': final String version} && final package,
          },
        } =>
          (
            version: Version.parse(version),
            source: package['source'] as String?,
          ),
        _ => null,
      };
    }

    final parent = p.dirname(dir);
    if (parent == dir) return null;
    dir = parent;
  }
}
