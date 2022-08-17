import 'package:dio/dio.dart';

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
    String? reviewId,
  }) {
    final buffer = StringBuffer()
      ..writeln('### 📦 Build')
      ..writeln()
      ..writeln(
        '- 🔗 [Widgetbook Cloud - Build](https://app.widgetbook.io/#/projects/$projectId/builds/$buildId)',
      );

    if (reviewId != null) {
      buffer
        ..writeln()
        ..writeln('### 📑 Review')
        ..writeln()
        ..writeln(
          '- 🔗 [Widgetbook Cloud - Review](https://app.widgetbook.io/#/projects/$projectId/reviews/$reviewId/overview)',
        );
    }

    return buffer.toString();
  }

  Future<void> addBuildComment({
    // TODO refactor to a proper type
    required Map<String, dynamic> buildInfo,
    required String number,
  });
}
