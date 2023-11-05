import 'package:flutter/material.dart';

import '../navigation/navigation.dart';
import '../settings/settings.dart';
import '../state/state.dart';

mixin WidgetbookShellMixin on StatelessWidget {
  Widget buildNavigationPanel(BuildContext context, WidgetbookState state) {
    return NavigationPanel(
      initialPath: state.path,
      root: state.root,
      onNodeSelected: (node) {
        WidgetbookState.of(context).updatePath(node.path);
      },
    );
  }

  SettingsPanelData buildAddonsPanel(
    BuildContext context,
    WidgetbookState state,
  ) {
    return SettingsPanelData(
      name: 'Addons',
      builder: (context) => state.addons != null
          ? state.effectiveAddons!
              .map((addon) => addon.buildFields(context))
              .toList()
          : [],
    );
  }

  SettingsPanelData buildKnobsPanel(
    BuildContext context,
    WidgetbookState state,
  ) {
    return SettingsPanelData(
      name: 'Knobs',
      builder: (context) =>
          state.knobs.values.map((knob) => knob.buildFields(context)).toList(),
    );
  }
}
