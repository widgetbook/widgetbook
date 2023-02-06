import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/modification.dart';

part 'changed_use_case.freezed.dart';
part 'changed_use_case.g.dart';

@freezed
class ChangedUseCase with _$ChangedUseCase {
  factory ChangedUseCase({
    required String name,
    required String componentName,
    required String componentDefinitionPath,
    required Modification modification,
    required String? designLink,
  }) = _ChangedUseCase;

  factory ChangedUseCase.fromJson(Map<String, dynamic> json) =>
      _$ChangedUseCaseFromJson(json);
}
