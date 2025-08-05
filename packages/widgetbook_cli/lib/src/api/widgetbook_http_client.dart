import 'package:dio/dio.dart';

import 'cloud_exception.dart';
import 'models/create_build_request.dart';
import 'models/create_build_response.dart';
import 'models/submit_build_request.dart';
import 'models/submit_build_response.dart';
import 'models/versions_metadata.dart';

const BASE_API_URL = 'https://api.widgetbook.io/';

/// HTTP client to connect to the Widgetbook Cloud backend
class WidgetbookHttpClient {
  WidgetbookHttpClient({
    Dio? client,
  }) : client =
           client ??
           Dio(
             BaseOptions(
               baseUrl: BASE_API_URL,
               contentType: Headers.jsonContentType,
             ),
           );

  final Dio client;

  /// Creates a new build that can be either a draft or a turbo build.
  Future<CreateBuildResponse> createBuild(
    VersionsMetadata? versions,
    CreateBuildRequest request,
  ) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        'v2/builds',
        data: request.toJson(),
        options: Options(
          headers: versions?.toHeaders(),
        ),
      );

      return CreateBuildResponse.fromJson(response.data!);
    } catch (e, stackTrace) {
      throw CloudException.parse(e, stackTrace);
    }
  }

  /// If [createBuild] return s a [CreateDraftBuildResponse],
  /// this method can be used to submit the build draft.
  Future<SubmitBuildResponse> submitBuild(
    SubmitBuildRequest request,
  ) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        'v2/builds/submit',
        data: request.toJson(),
      );

      return SubmitBuildResponse.fromJson(response.data!);
    } catch (e, stackTrace) {
      throw CloudException.parse(e, stackTrace);
    }
  }
}
