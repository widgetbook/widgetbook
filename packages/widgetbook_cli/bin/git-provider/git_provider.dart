import 'package:dio/dio.dart';

import '../flavor/flavor.dart';

abstract class GitProvider {
  GitProvider({
    required this.apiKey,
    required this.url,
    Dio? client,
  }) : client = client ?? Dio() {
    this.client.options.headers.putIfAbsent(
          'Authorization',
          () => 'token $apiKey',
        );
  }

  final String apiKey;
  final Dio client;
  final String url;

  String commentBody({
    required String projectId,
    required String buildId,
    required String? reviewId,
  }) {
    final prefix = Flavor().isProduction ? 'https://' : 'https://dev.';
    final buffer = StringBuffer()
      ..writeln('### 📦 Build')
      ..writeln()
      ..writeln(
        '- 🔗 [Widgetbook Cloud - Build](${prefix}app.widgetbook.io/#/projects/$projectId/builds/$buildId)',
      );

    if (reviewId != null) {
      buffer
        ..writeln()
        ..writeln('### 📑 Review')
        ..writeln()
        ..writeln(
          '- 🔗 [Widgetbook Cloud - Review](${prefix}app.widgetbook.io/#/projects/$projectId/reviews/$reviewId/builds/$buildId/use-cases)',
        );
    }

    return buffer.toString();
  }

  Future<void> addBuildComment({
    // TODO refactor to a proper type
    required Map<String, dynamic> buildInfo,
    required String number,
    required String? reviewId,
  });
}
