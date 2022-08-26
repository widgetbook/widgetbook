import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'builder_data.freezed.dart';

@freezed
class BuilderData with _$BuilderData {
  factory BuilderData({
    required Widget Function(BuildContext, Widget child) appBuilder,
  }) = _BuilderData;
}
