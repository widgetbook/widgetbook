import 'package:freezed_annotation/freezed_annotation.dart';

part 'ci_args.freezed.dart';

@freezed
class CiArgs with _$CiArgs {
  const factory CiArgs({
    String? actor,
    String? repository,
    required String vendor,
  }) = _CiArgs;
}
