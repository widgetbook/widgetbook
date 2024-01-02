import 'package:dio/dio.dart';
import 'package:file/file.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import '../../models/models.dart';

class BuildRequest {
  const BuildRequest({
    required this.apiKey,
    required this.branchName,
    required this.repositoryName,
    required this.commitSha,
    required this.actor,
    required this.provider,
    required this.file,
    required this.takeScreenshots,
    required this.useCases,
    required this.baseSha,
  });

  final String apiKey;
  final String branchName;
  final String repositoryName;
  final String commitSha;
  final String actor;
  final String provider;
  final File file;

  // Experimental Visual Diff
  final bool takeScreenshots;
  final List<ChangedUseCase>? useCases;
  final String? baseSha;

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'api-key': apiKey,
      'branch': branchName,
      'repository': repositoryName,
      'commit': commitSha,
      'actor': actor,
      'version-control-provider': provider,
      'file': await MultipartFile.fromFile(
        file.path,
        filename: basename(file.path),
        contentType: MediaType.parse('application/zip'),
      ),
      'take-screenshots': takeScreenshots,
      'use-cases': useCases?.map((x) => x.toJson()).toList(),
      'base-sha': baseSha,
    });
  }
}
