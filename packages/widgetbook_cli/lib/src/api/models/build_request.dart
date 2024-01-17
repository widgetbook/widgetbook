import 'package:dio/dio.dart';
import 'package:file/file.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

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
