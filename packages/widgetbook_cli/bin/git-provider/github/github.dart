import 'dart:io';

import 'package:path/path.dart' as path;

import '../git_provider.dart';
import 'comment.dart';

class GithubProvider extends GitProvider {
  GithubProvider({
    required super.apiKey,
  }) : super(url: 'https://api.github.com');

  @override
  Future<void> addBuildComment({
    required Map<String, dynamic> buildInfo,
    required String number,
    required String? reviewId,
  }) async {
    final repository = Platform.environment['GITHUB_REPOSITORY'];
    final projectId = buildInfo['project'] as String;
    final buildId = buildInfo['build'] as String;

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
