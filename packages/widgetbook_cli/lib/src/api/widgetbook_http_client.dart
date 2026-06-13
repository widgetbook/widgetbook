import 'package:dio/dio.dart';

import 'cloud_exception.dart';
import 'models/append_snapshots_request.dart';
import 'models/append_snapshots_response.dart';
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
        'v4/builds',
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

  /// Appends a batch of snapshot metadata to an in-progress (draft) batched
  /// build created by [createBuild]. The [buildId] is a path param.
  ///
  /// Sends the same version headers as [createBuild] because the server gates
  /// the append endpoint behind a minimum CLI version.
  Future<AppendSnapshotsResponse> appendSnapshots(
    VersionsMetadata? versions,
    String buildId,
    AppendSnapshotsRequest request,
  ) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        'v4/builds/$buildId/snapshots',
        data: request.toJson(),
        options: Options(
          headers: versions?.toHeaders(),
        ),
      );

      return AppendSnapshotsResponse.fromJson(response.data!);
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
        'v4/builds/submit',
        data: request.toJson(),
      );

      return SubmitBuildResponse.fromJson(response.data!);
    } catch (e, stackTrace) {
      throw CloudException.parse(e, stackTrace);
    }
  }
}
