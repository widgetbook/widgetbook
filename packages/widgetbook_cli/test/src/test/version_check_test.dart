@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';
import 'package:widgetbook_cli/src/core/cli_exception.dart';
import 'package:widgetbook_cli/src/test/test_exit_codes.dart';
import 'package:widgetbook_cli/src/test/version_check.dart';

void main() {
  group('checkWidgetbookVersion', () {
    late Directory root;

    setUp(() {
      root = Directory.systemTemp.createTempSync('wb_version_check');
    });

    tearDown(() => root.deleteSync(recursive: true));

    void writeLock(
      String dir,
      String? widgetbookVersion, {
      String source = 'hosted',
    }) {
      File(p.join(dir, 'pubspec.lock'))
        ..createSync(recursive: true)
        ..writeAsStringSync('''
packages:
  path:
    dependency: transitive
    version: "1.9.1"
${widgetbookVersion == null ? '' : '''
  widgetbook:
    dependency: "direct main"
    source: $source
    version: "$widgetbookVersion"
'''}
sdks:
  dart: ">=3.13.0 <4.0.0"
''');
    }

    void check([String? dir]) {
      checkWidgetbookVersion(
        projectDir: dir ?? root.path,
        flag: '--no-snapshots',
        minVersion: Version.parse('4.0.0-beta.16'),
      );
    }

    Matcher throwsVersionError(String message) {
      return throwsA(
        isA<CliException>()
            .having(
              (e) => e.exitCode,
              'exitCode',
              TestExitCodes.unsupportedVersion,
            )
            .having((e) => e.message, 'message', contains(message)),
      );
    }

    test('passes for the minimum version and newer ones', () {
      for (final version in ['4.0.0-beta.16', '4.0.0-beta.20', '4.0.0']) {
        writeLock(root.path, version);
        expect(check, returnsNormally, reason: version);
      }
    });

    test('throws for an older version', () {
      writeLock(root.path, '4.0.0-beta.15');

      expect(
        check,
        throwsVersionError(
          '--no-snapshots requires widgetbook >= 4.0.0-beta.16 '
          '(found 4.0.0-beta.15)',
        ),
      );
    });

    test('reads the lock file of a workspace root', () {
      writeLock(root.path, '4.0.0-beta.15');
      final package = Directory(p.join(root.path, 'packages', 'widgetbook'))
        ..createSync(recursive: true);

      expect(() => check(package.path), throwsVersionError('found'));
    });

    test('skips a path dependency', () {
      writeLock(root.path, '4.0.0-beta.15', source: 'path');

      expect(check, returnsNormally);
    });

    test('throws when widgetbook is not in the lock file', () {
      writeLock(root.path, null);

      expect(check, throwsVersionError('run flutter pub get'));
    });
  });
}
