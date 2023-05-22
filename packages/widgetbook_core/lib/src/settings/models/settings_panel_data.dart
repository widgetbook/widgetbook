import 'package:flutter/widgets.dart';

class SettingsPanelData {
  const SettingsPanelData({
    required this.name,
    required this.settings,
  });

  final String name;
  final List<Widget> settings;
}
