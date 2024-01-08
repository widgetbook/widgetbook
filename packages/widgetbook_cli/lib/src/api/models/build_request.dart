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
  });

  final String apiKey;
  final String branchName;
  final String repositoryName;
  final String commitSha;
  final String actor;
  final String provider;
  final File file;

  Map<String, dynamic> toJson() {
    return {
      'api-key': apiKey,
      'branch': branchName,
      'repository': repositoryName,
      'commit': commitSha,
      'actor': actor,
      'version-control-provider': provider,
    };
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      ...toJson(),
      'file': await MultipartFile.fromFile(
        file.path,
        filename: basename(file.path),
        contentType: MediaType.parse('application/zip'),
      ),
    });
  }
}

class BuildRequestNext extends BuildRequest {
  const BuildRequestNext({
    required super.apiKey,
    required super.branchName,
    required super.repositoryName,
    required super.commitSha,
    required super.actor,
    required super.provider,
    required super.file,
    required this.baseSha,
    required this.useCases,
  });

  final String baseSha;
  final List<UseCaseMetadata> useCases;

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'base-sha': baseSha,
      'use-cases': useCases.map((x) => x.toJson()).toList(),
    };
  }
}
