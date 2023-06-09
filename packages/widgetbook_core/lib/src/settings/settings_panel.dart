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

    return Card(
      child: Theme(
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
        child: ListView.builder(
          itemCount: settings.length,
          itemBuilder: (context, index) {
            final item = settings[index];

            return ExpansionTile(
              collapsedShape: const RoundedRectangleBorder(),
              shape: const RoundedRectangleBorder(),
              initiallyExpanded: true,
              title: Text(item.name),
              children: item.settings.isEmpty
                  ? [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('No ${item.name} available'),
                      )
                    ]
                  : item.settings,
            );
          },
        ),
      ),
    );
  }
}
