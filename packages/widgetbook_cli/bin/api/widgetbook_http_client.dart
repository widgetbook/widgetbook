import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import '../flavor/flavor.dart';
import '../helpers/helpers.dart';
import '../models/create_review_response.dart';
import '../models/models.dart';
import '../review/use_cases/models/changed_use_case.dart';
import '../review/use_cases/requests/create_use_cases_request.dart';

/// A client to connect to the Widgetbook Cloud backend
class WidgetbookHttpClient {
  /// Creates a new instance of [WidgetbookHttpClient].
  WidgetbookHttpClient({
    Dio? client,
  }) : client = client ?? Dio() {
    this.client.options.baseUrl = _getUrl();
  }

  String _getUrl() {
    switch (Flavor().strategy) {
      case DeploymentStrategy.production:
        return 'https://api.widgetbook.io/v1/';
      case DeploymentStrategy.staging:
        return 'https://staging.api.widgetbook.io/v1/';
      case DeploymentStrategy.debug:
        return 'http://localhost:3000/v1/';
    }
  }

  /// underlying [Dio] client
  final Dio client;

  Future<CreateReviewResponse?> uploadReview({
    required String apiKey,
    required List<ChangedUseCase> useCases,
    required String buildId,
    required String projectId,
    required String baseBranch,
    required String headBranch,
    required String baseSha,
    required String headSha,
  }) async {
    if (useCases.isNotEmpty) {
      try {
        final createReviewResponse = await client.post<dynamic>(
          '/reviews',
          data: CreateUseCasesRequest(
            apiKey: apiKey,
            useCases: useCases,
            buildId: buildId,
            projectId: projectId,
            baseBranch: baseBranch,
            headBranch: headBranch,
            baseSha: baseSha,
            headSha: headSha,
          ).toJson(),
        );
        return CreateReviewResponse.fromJson(
          jsonDecode(
            jsonEncode(
              createReviewResponse.data as Map<String, dynamic>,
            ),
          ) as Map<String, dynamic>,
        );
      } on DioError catch (e) {
        final response = e.response;
        if (response != null) {
          final errorResponse = _decodeResponse(response.data);

          throw WidgetbookPublishReviewException(
            message: errorResponse.toString(),
          );
        }
        throw WidgetbookPublishReviewException();
      } catch (e) {
        throw WidgetbookPublishReviewException();
      }
    }
    return null;
  }

  /// Uploads the deployment .zip file to the Widgetbook Cloud backend
  Future<Map<String, dynamic>?> uploadBuild({
    required File deploymentFile,
    required CreateBuildRequest data,
  }) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        '/builds/deploy',
        data: FormData.fromMap(
          <String, dynamic>{
            'file': await MultipartFile.fromFile(
              deploymentFile.path,
              filename: basename(deploymentFile.path),
              contentType: MediaType.parse('application/zip'),
            ),
            'themes': jsonEncode(data.themes),
            'devices': jsonEncode(data.devices),
            'locales': jsonEncode(data.locales),
            'textScaleFactors': jsonEncode(data.textScaleFactors),
            'branch': data.branchName,
            'repository': data.repositoryName,
            'actor': data.actor,
            'commit': data.commitSha,
            'version-control-provider': data.provider,
            'api-key': data.apiKey,
            'devices': jsonEncode(data.devices),
            'themes': jsonEncode(data.themes),
            'textScaleFactors': jsonEncode(data.textScaleFactors),
            'locales': jsonEncode(data.locales),
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      final response = e.response;
      if (response != null) {
        final errorResponse = _decodeResponse(response.data);

        throw WidgetbookDeployException(message: errorResponse.toString());
      }
    } catch (e) {
      throw WidgetbookDeployException();
    }

    return null;
  }

  Map<String, dynamic> _decodeResponse(dynamic data) {
    if (data is String) {
      return json.decode(data) as Map<String, dynamic>;
    }
    return data as Map<String, dynamic>;
  }
}
