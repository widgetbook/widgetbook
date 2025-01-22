import 'package:dio/dio.dart';

import '../core/core.dart';
import '../utils/utils.dart';
import 'models/build_draft_request.dart';
import 'models/build_draft_response.dart';
import 'models/build_ready_request.dart';
import 'models/build_ready_response.dart';
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

  Future<BuildDraftResponse> createBuildDraft(
    VersionsMetadata? versions,
    BuildDraftRequest request,
  ) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        'v2/builds/draft',
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
        'v2/builds/submit',
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
}
