import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_section_data.freezed.dart';

@freezed
class SettingSectionData with _$SettingSectionData {
  factory SettingSectionData({
    required String name,
    required List<Widget> settings,
  }) = _SettingSectionData;
}
