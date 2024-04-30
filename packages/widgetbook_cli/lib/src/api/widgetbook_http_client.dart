import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file/file.dart';

import '../core/core.dart';
import '../utils/utils.dart';
import 'models/build_draft_request.dart';
import 'models/build_draft_response.dart';
import 'models/build_ready_request.dart';
import 'models/build_ready_response.dart';
import 'models/build_request.dart';
import 'models/build_response.dart';
import 'models/versions_metadata.dart';

/// HTTP client to connect to the Widgetbook Cloud backend
class WidgetbookHttpClient {
  WidgetbookHttpClient({
    Dio? client,
    required Environment environment,
  }) : client = client ??
            Dio(
              BaseOptions(
                baseUrl: environment.apiUrl,
                contentType: Headers.jsonContentType,
              ),
            );

  final Dio client;

  /// Uploads the build .zip file to the Widgetbook Cloud backend.
  Future<BuildResponse> uploadBuild(
    VersionsMetadata? versions,
    BuildRequest request,
  ) async {
    try {
      final formData = await request.toFormData();
      final response = await client.post<Map<String, dynamic>>(
        'v1/builds/deploy',
        data: formData,
        options: Options(
          headers: versions?.toHeaders(),
        ),
      );

      return BuildResponse.fromJson(response.data!);
    } catch (e) {
      final message = e is DioException //
          ? e.response?.toString()
          : e.toString();

      throw WidgetbookApiException(
        message: message,
      );
    }
  }

  Future<BuildDraftResponse> createBuildDraft(
    VersionsMetadata? versions,
    BuildDraftRequest request,
  ) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        'v1.5/builds/draft',
        data: request.toJson(),
        options: Options(
          headers: versions?.toHeaders(),
        ),
      );

      return BuildDraftResponse.fromJson(response.data!);
    } catch (e) {
      final message = e is DioException //
          ? e.response?.toString()
          : e.toString();

      throw WidgetbookApiException(
        message: message,
      );
    }
  }

  Future<BuildReadyResponse> submitBuildDraft(
    BuildReadyRequest request,
  ) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        'v1.5/builds/submit',
        data: request.toJson(),
      );

      return BuildReadyResponse.fromJson(response.data!);
    } catch (e) {
      final message = e is DioException //
          ? e.response?.toString()
          : e.toString();

      throw WidgetbookApiException(
        message: message,
      );
    }
  }

  Future<void> uploadBuildFile(String signedUrl, File zipFile) {
    return client.put<void>(
      signedUrl,
      data: zipFile.openRead(),
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: 'application/zip',
          HttpHeaders.contentLengthHeader: zipFile.lengthSync(),
        },
      ),
    );
  }
}
