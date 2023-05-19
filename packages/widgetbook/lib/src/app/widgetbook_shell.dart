import 'package:flutter/material.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

import '../state/state.dart';
import 'settings_panel.dart';

class WidgetbookShell extends StatelessWidget {
  const WidgetbookShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    final enableNavigation = state.panels.contains(
      WidgetbookPanel.navigation,
    );

    final enableSettings = state.panels.any(
      (x) => x == WidgetbookPanel.addons || x == WidgetbookPanel.knobs,
    );

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          if (enableNavigation) ...{
            core.NavigationPanel(
              initialPath: state.uri.toString(),
              onNodeSelected: (path, _) {
                WidgetbookState.of(context).updatePath(path);
              },
            )
          },
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 2,
              ),
              child: child,
            ),
          ),
          if (enableSettings) ...{
            const SizedBox(
              width: 400,
              child: SettingsPanel(),
            ),
          }
        ],
      ),
    );
  }
}
