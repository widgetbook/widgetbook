import 'package:dio/dio.dart';

import '../flavor/flavor.dart';
import '../helpers/helpers.dart';
import 'models/build_request.dart';
import 'models/build_response.dart';
import 'models/review_request.dart';
import 'models/review_response.dart';

/// A client to connect to the Widgetbook Cloud backend
class WidgetbookHttpClient {
  /// Creates a new instance of [WidgetbookHttpClient].
  WidgetbookHttpClient({
    Dio? client,
  }) : client = client ?? Dio() {
    this.client.options.baseUrl = _getUrl();
    this.client.options.contentType = Headers.jsonContentType;
    this.client.options.responseType = ResponseType.json;
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

  Future<ReviewResponse> uploadReview(
    ReviewRequest request,
  ) async {
    if (request.useCases.isEmpty) {
      throw WidgetbookApiException(
        message: 'No use cases to upload',
      );
    }

    try {
      final response = await client.post<Map<String, dynamic>>(
        '/reviews',
        data: request.toJson(),
      );

      return ReviewResponse.fromJson(response.data!);
    } catch (e) {
      final message = e is DioException //
          ? e.response?.toString()
          : e.toString();

      throw WidgetbookApiException(
        message: message,
      );
    }
  }

  /// Uploads the deployment .zip file to the Widgetbook Cloud backend
  Future<BuildResponse> uploadBuild(
    BuildRequest request,
  ) async {
    try {
      final formData = await request.toFormData();
      final response = await client.post<Map<String, dynamic>>(
        '/builds/deploy',
        data: formData,
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
