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

  Future<void> addBuildComment({
    // TODO refactor to a proper type
    required Map<String, dynamic> buildInfo,
    required String number,
  });
}
