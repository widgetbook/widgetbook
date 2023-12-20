import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:crypto/crypto.dart';

import '../../metadata.dart';
import 'ci_keys.dart';
import 'usage_report.dart';

class TelemetryReporter extends Builder {
  TelemetryReporter({
    required this.isDebug,
  });

  final bool isDebug;

  static const banner = '''\n
    ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    ┃                                                            ┃
    ┃   Widgetbook Generator now collects and reports anonymous  ┃
    ┃   usage information that helps us improve our package.     ┃
    ┃                                                            ┃
    ┃   For more info visit:                                     ┃
    ┃   https://docs.widgetbook.io/telemetry                     ┃
    ┃                                                            ┃
    ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  ''';

  @override
  Map<String, List<String>> get buildExtensions => {
        'components.book.dart': ['.track'],
      };

  /// Get a tracking ID based on git's config.
  /// No sensitive data is collected during the process,
  /// and all data is hashed before usage.
  Future<String?> getTrackingId() async {
    try {
      final result = await Process.run('git', ['config', 'user.email']);
      final gitUser = result.stdout.toString().trim();

      if (gitUser.isEmpty) return null;

      final bytes = utf8.encode(gitUser);
      final digest = sha1.convert(bytes);
      return digest.toString();
    } catch (_) {
      return null;
    }
  }

  Future<void> sendUsageReport(UsageReport report) async {
    final projectToken = 'e9326ce582275574ff5e5691295cd420';
    final event = report.toMixpanelEvent(
      isDebug: isDebug,
      token: projectToken,
    );

    if (isDebug) {
      const encoder = JsonEncoder.withIndent('  ');
      final prettyBody = encoder.convert(event);

      log.info('\nSending Usage Report:\n$prettyBody');
    }

    final uri = Uri.parse('https://api-eu.mixpanel.com/track');
    final client = HttpClient();
    final request = await client.postUrl(uri);
    final body = jsonEncode([event]);

    // Headers must be set before writing the body
    request.headers.set(HttpHeaders.acceptHeader, 'text/plain');
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.write(body);

    // Cleanup to avoid memory leaks and build process hangs
    final response = await request.close();
    response.drain(0);
    client.close();
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    try {
      final isCI = ciKeys.any(Platform.environment.containsKey);
      if (isCI) return;

      final trackingId = await getTrackingId();
      if (trackingId == null) return;

      final lockFile = File('.dart_tool/widgetbook/telemetry.lock');
      final firstRun = !lockFile.existsSync();

      if (firstRun) {
        log.info(banner);
        lockFile.create(
          recursive: true,
        );
      }

      final report = UsageReport.from(
        trackingId: trackingId,
        project: buildStep.inputId.package,
        version: packageVersion,
      );

      await sendUsageReport(report);
    } catch (err) {
      // Swallow any exceptions without doing anything,
      // not to disturb the build process.
      if (isDebug) {
        log.info('\nFailed to send usage report:\n$err');
      }
    }
  }
}
