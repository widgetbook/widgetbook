import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/settings/models/settings_panel_data.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: settings
            .map(
              (e) => ExpansionTile(
                collapsedShape: const RoundedRectangleBorder(),
                shape: const RoundedRectangleBorder(),
                initiallyExpanded: true,
                title: Text(
                  e.name,
                ),
                children: e.settings.isEmpty
                    ? [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text('No ${e.name} available'),
                        )
                      ]
                    : e.settings,
              ),
            )
            .toList(),
      ),
    );
  }
}
