import 'package:flutter/widgets.dart';

class SettingSectionData {
  const SettingSectionData({
    required this.name,
    required this.settings,
  });

  final String name;
  final List<Widget> settings;
}
