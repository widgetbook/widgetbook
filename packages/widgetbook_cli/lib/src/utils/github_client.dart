import 'dart:io';

import 'package:dio/dio.dart';

class GitHubClient {
  GitHubClient({
    required String apiKey,
    Dio? client,
  }) : client = client ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.github.com/',
                contentType: Headers.jsonContentType,
                headers: {HttpHeaders.authorizationHeader: 'token $apiKey'},
              ),
            );

  final Dio client;

  Future<void> postComment({
    required String repository,
    required String prNumber,
    required String body,
  }) async {
    await client.post<dynamic>(
      '/repos/$repository/issues/$prNumber/comments',
      data: {'body': body},
    );
  }
}
