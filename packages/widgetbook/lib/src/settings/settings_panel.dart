import 'package:flutter/material.dart';

class SettingsPanelData {
  SettingsPanelData({
    required this.name,
    required this.builder,
  });

  final String name;
  final List<Widget> Function(BuildContext context) builder;
}

class SettingsPanel extends StatelessWidget {
  SettingsPanel({
    super.key,
    required this.settings,
  });

  final List<SettingsPanelData> settings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: settings.length,
      itemBuilder: (context, index) {
        final setting = settings[index];
        final children = setting.builder(context);

        return ExpansionTile(
          initiallyExpanded: true,
          title: Text(setting.name),
          children: children.isNotEmpty
              ? children
              : [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('No ${setting.name} available'),
                  ),
                ],
        );
      },
    );
  }
}
