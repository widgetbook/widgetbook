import 'package:freezed_annotation/freezed_annotation.dart';

import '../helpers/ci_parser.dart';
import '../helpers/helpers.dart';

part 'pipeline_data.freezed.dart';
part 'pipeline_data.g.dart';

@freezed
class PipelineData with _$PipelineData {
  factory PipelineData({
    final String? actorName,
    final String? repository,
    required PipelineVendor pipeline,
  }) = _PipelineData;

  factory PipelineData.fromJson(Map<String, dynamic> json) =>
      _$PipelineDataFromJson(json);
}
