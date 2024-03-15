import 'package:dio/dio.dart';

import '../core/core.dart';
import '../utils/utils.dart';
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
        '/builds/deploy',
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
}
