import 'dart:io';

import 'package:path/path.dart' as path;

import '../git_provider.dart';
import 'comment.dart';

class GithubProvider extends GitProvider {
  GithubProvider({
    required super.apiKey,
    required super.environment,
  }) : super(
          url: 'https://api.github.com',
        );

  @override
  Future<void> addBuildComment({
    required String number,
    required String projectId,
    required String buildId,
    required String? reviewId,
  }) async {
    final repository = Platform.environment['GITHUB_REPOSITORY'];

    await client.post<dynamic>(
      path.join(
        url,
        'repos',
        repository,
        'issues',
        number,
        'comments',
      ),
      data: Comment(
        body: commentBody(
          projectId: projectId,
          buildId: buildId,
          reviewId: reviewId,
        ),
      ).toJson(),
    );
  }
}
