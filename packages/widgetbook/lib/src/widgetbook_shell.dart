import 'package:flutter/material.dart';
import 'package:widgetbook/src/settings_panel/settings_panel.dart';

import 'navigation/navigation.dart';
import 'state/state.dart';

class WidgetbookShell extends StatelessWidget {
  const WidgetbookShell({
    required this.child,
    super.key,
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
            NavigationPanelWrapper(
              initialPath: state.uri.toString(),
            ),
          },
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 2,
              ),
              child: child,
            ),
          ),
          if (enableSettings) ...{
            SizedBox(
              width: 400,
              child: SettingsPanel(),
            ),
          }
        ],
      ),
    );
  }
}
