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
    return DefaultTabController(
      animationDuration: Duration.zero,
      length: settings.length,
      child: Column(
        children: [
          if (settings.length > 1)
            TabBar(
              tabs: settings
                  .map(
                    (setting) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      child: Text(
                        setting.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
            ),
          Expanded(
            child: TabBarView(
              children: settings.map(
                (setting) {
                  final children = setting.builder(context);

                  return children.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text('No ${setting.name} available'),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            children: children,
                          ),
                        );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
