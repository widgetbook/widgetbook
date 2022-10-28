import 'package:freezed_annotation/freezed_annotation.dart';

import '../helpers/helpers.dart';

part 'package.freezed.dart';
part 'package.g.dart';

@freezed
class Package with _$Package {
  factory Package({
    /// The project name
    required String name,

    /// Path of the project
    required String path,

    /// Type of the project (Dart Package or a Flutter Project)
    required PackageType type,
  }) = _Package;

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
}
