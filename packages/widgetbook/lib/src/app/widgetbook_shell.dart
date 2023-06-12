import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

import '../state/state.dart';

class WidgetbookShell extends StatelessWidget {
  const WidgetbookShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: ResizableWidget(
        separatorSize: 2,
        percentages: [0.2, 0.6, 0.2],
        separatorColor: Colors.white24,
        children: [
          core.NavigationPanel(
            initialPath: state.path,
            directories: state.directories,
            onNodeSelected: (path, _) {
              WidgetbookState.of(context).updatePath(path);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
            ),
            child: child,
          ),
          core.SettingsPanel(
            settings: [
              if (state.addons != null) ...{
                core.SettingsPanelData(
                  name: 'Properties',
                  settings: state.addons!
                      .map((addon) => addon.buildSetting(context))
                      .toList(),
                ),
              },
              core.SettingsPanelData(
                name: 'Knobs',
                settings: state.knobs.values
                    .map((knob) => knob.build(context))
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
