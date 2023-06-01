import 'package:flutter/material.dart';

class SettingsPanelData {
  const SettingsPanelData({
    required this.name,
    required this.settings,
  });

  final String name;
  final List<Widget> settings;
}

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({
    super.key,
    required this.settings,
  });

  final List<SettingsPanelData> settings;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorScheme.surfaceVariant,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorScheme.primary,
            ),
          ),
          isDense: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      child: DefaultTabController(
        length: settings.length,
        child: Column(
          children: [
            TabBar(
              tabs: settings
                  .map(
                    (setting) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(setting.name),
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                children: settings
                    .map(
                      (setting) => SingleChildScrollView(
                        child: Column(
                          children: setting.settings.isEmpty
                              ? [
                                  Padding(
                                    padding: const EdgeInsets.all(32),
                                    child: Text('No ${setting.name} available'),
                                  )
                                ]
                              : setting.settings,
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
