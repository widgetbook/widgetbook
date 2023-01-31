import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_panel_data.freezed.dart';

@freezed
class SettingsPanelData with _$SettingsPanelData {
  factory SettingsPanelData({
    required String name,
    required List<Widget> settings,
  }) = _SettingsPanelData;
}
