import 'package:flutter/material.dart';

class SettingsPanelData {
  SettingsPanelData({
    required this.name,
    required this.children,
  });

  final String name;
  final List<Widget> children;
}

class SettingsPanel extends StatelessWidget {
  SettingsPanel({
    super.key,
    required this.settings,
  });

  final List<SettingsPanelData> settings;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) {
          final setting = settings[index];

          return ExpansionTile(
            initiallyExpanded: true,
            title: Text(setting.name),
            children: setting.children.isNotEmpty
                ? setting.children
                : [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('No ${setting.name} available'),
                    ),
                  ],
          );
        },
      ),
    );
  }
}
