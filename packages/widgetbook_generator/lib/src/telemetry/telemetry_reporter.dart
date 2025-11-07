import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:crypto/crypto.dart';

import '../../metadata.dart';
import '../generators/app_generator.dart';
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
    '.directories.g.dart': ['.track'],
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

  /// Get an ID for the project based on the SHA of the first
  /// commit in the repository.
  Future<String?> getProjectId() async {
    try {
      final result = await Process.run(
        'git',
        ['rev-list', '--max-parents=0', 'HEAD'],
      );

      final sha = result.stdout.toString().trim();

      return sha.isEmpty ? null : sha;
    } catch (_) {
      return null;
    }
  }

  /// Get an owner URL based on the remote origin URL.
  Future<String?> getOwnerUrl() async {
    try {
      final result = await Process.run('git', ['config', 'remote.origin.url']);
      final remoteUrl = result.stdout.toString().trim();

      if (remoteUrl.isEmpty) return null;

      // Convert SSH to HTTPs, e.g. git@github.com:owner/repo.git
      // will be converted to https://github.com/owner/repo.git
      final isSSH = remoteUrl.startsWith('git@');
      final httpUrl = isSSH
          ? remoteUrl.replaceAll(':', '/').replaceFirst('git@', 'https://')
          : remoteUrl;

      // Remove the repo name as it may contain sensitive information.
      final ownerUrl = httpUrl.substring(0, httpUrl.lastIndexOf('/'));

      return ownerUrl;
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

      // Owner URL can be null if the repository has no remote,
      // Or a remote that's not named `origin`.
      final ownerUrl = await getOwnerUrl();

      final trackingId = await getTrackingId();
      if (trackingId == null) return;

      final projectId = await getProjectId();
      if (projectId == null) return;

      final lockFile = File('.dart_tool/widgetbook/telemetry.lock');
      final firstRun = !lockFile.existsSync();

      if (firstRun) {
        log.info(banner);
        lockFile.create(
          recursive: true,
        );
      }

      final useCases = await AppGenerator.readUseCases(buildStep);
      final report = UsageReport.from(
        trackingId: trackingId,
        projectId: projectId,
        project: buildStep.inputId.package,
        useCases: useCases,
        version: packageVersion,
        ownerUrl: ownerUrl,
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
