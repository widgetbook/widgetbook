import 'dart:io';

import 'package:path/path.dart' as path;

import '../../models/build_upload_response.dart';
import '../git_provider.dart';
import 'comment.dart';

class GithubProvider extends GitProvider {
  GithubProvider({
    required super.apiKey,
  }) : super(url: 'https://api.github.com');

  @override
  Future<void> addBuildComment({
    required BuildUploadResponse buildInfo,
    required String number,
    required String? reviewId,
  }) async {
    final repository = Platform.environment['GITHUB_REPOSITORY'];
    final projectId = buildInfo.project;
    final buildId = buildInfo.build;

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
