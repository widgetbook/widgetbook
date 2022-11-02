import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import '../flavor/flavor.dart';
import '../helpers/helpers.dart';
import '../models/models.dart';
import '../review/devices/models/device_data.dart';
import '../review/locales/models/locale_data.dart';
import '../review/text_scale_factors/models/text_scale_factor_data.dart';
import '../review/themes/models/theme_data.dart';
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

  Future<void> uploadReview({
    required String apiKey,
    required List<ChangedUseCase> useCases,
    required String buildId,
    required String projectId,
    required String baseBranch,
    required String headBranch,
    required String baseSha,
    required String headSha,
    required List<ThemeData> themes,
    required List<LocaleData> locales,
    required List<DeviceData> devices,
    required List<TextScaleFactorData> textScaleFactors,
  }) async {
    if (useCases.isNotEmpty) {
      try {
        await client.post<dynamic>(
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
            themes: themes,
            locales: locales,
            devices: devices,
            textScaleFactors: textScaleFactors,
          ).toJson(),
        );
      } on DioError catch (e) {
        final response = e.response;
        if (response != null) {
          final errorResponse = _decodeResponse(response.data);

          throw WidgetbookPublishReviewException(
            message: errorResponse.toString(),
          );
        }
      } catch (e) {
        throw WidgetbookPublishReviewException();
      }
    }
  }

  /// Uploads the deployment .zip file to the Widgetbook Cloud backend
  Future<Map<String, dynamic>?> uploadDeployment({
    required File deploymentFile,
    required DeploymentData data,
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
            'branch': data.branchName,
            'repository': data.repositoryName,
            'actor': data.actor,
            'commit': data.commitSha,
            'version-control-provider': data.provider,
            'api-key': data.apiKey,
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
