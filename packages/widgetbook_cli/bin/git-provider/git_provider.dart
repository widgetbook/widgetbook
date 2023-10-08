import 'package:dio/dio.dart';

import '../core/environment.dart';

abstract class GitProvider {
  GitProvider({
    required this.apiKey,
    required this.url,
    required this.environment,
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
  final Environment environment;

  String commentBody({
    required String projectId,
    required String buildId,
    required String? reviewId,
  }) {
    final buffer = StringBuffer()
      ..writeln('### 📦 Build')
      ..writeln()
      ..writeln(
        '- 🔗 [Widgetbook Cloud - Build]'
        '(${environment.appUrl}#/projects/$projectId/builds/$buildId)',
      );

    if (reviewId != null) {
      buffer
        ..writeln()
        ..writeln('### 📑 Review')
        ..writeln()
        ..writeln(
          '- 🔗 [Widgetbook Cloud - Review]'
          '(${environment.appUrl}/#/projects/$projectId/reviews/$reviewId/builds/$buildId/use-cases)',
        );
    }

    return buffer.toString();
  }

  Future<void> addBuildComment({
    required String number,
    required String projectId,
    required String buildId,
    required String? reviewId,
  });
}
