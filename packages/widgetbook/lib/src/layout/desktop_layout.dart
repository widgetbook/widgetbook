import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../settings/settings.dart';
import '../state/state.dart';
import 'base_layout.dart';

extension _BoolExtension on bool {
  int toInt() => this ? 1 : 0;
}

class DesktopLayout extends StatelessWidget implements BaseLayout {
  const DesktopLayout({
    super.key,
    required this.navigationBuilder,
    required this.addonsBuilder,
    required this.knobsBuilder,
    required this.argsBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) knobsBuilder;
  final List<Widget> Function(BuildContext context) argsBuilder;
  final Widget workbench;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    // Original percentages for panels and workbench
    final originalPanelPercentage = 0.2;
    final originalWorkbenchPercentage = 1 - (2 * originalPanelPercentage);

    final showNavigationPanel = state.canShowPanel(LayoutPanel.navigation);
    final showSettingsPanel = state.canShowPanel(LayoutPanel.addons) ||
        state.canShowPanel(LayoutPanel.knobs);

    // If some panels are missing, distribute the remaining percentage
    // equally among the remaining panels and the workbench
    final missingPanelsCount =
        2 - showNavigationPanel.toInt() - showSettingsPanel.toInt();
    final childrenCount = 1 + (2 - missingPanelsCount);

    final remainingPercentage = missingPanelsCount * originalPanelPercentage;
    final extraPercentage = remainingPercentage / childrenCount;

    return ColoredBox(
      key: ValueKey(state.isNext), // Rebuild when switching to next
      color: Theme.of(context).colorScheme.surface,
      child: ResizableWidget(
        separatorSize: 2,
        percentages: [
          if (showNavigationPanel) originalPanelPercentage + extraPercentage,
          originalWorkbenchPercentage + extraPercentage,
          if (showSettingsPanel) originalPanelPercentage + extraPercentage,
        ],
        separatorColor: Colors.white24,
        children: [
          if (showNavigationPanel)
            Card(
              child: navigationBuilder(context),
            ),
          workbench,
          if (showSettingsPanel)
            Card(
              child: SettingsPanel(
                settings: [
                  if (state.canShowPanel(LayoutPanel.knobs)) ...{
                    if (state.isNext) ...{
                      SettingsPanelData(
                        name: 'Args',
                        builder: argsBuilder,
                      ),
                    } else ...{
                      SettingsPanelData(
                        name: 'Knobs',
                        builder: knobsBuilder,
                      ),
                    },
                  },
                  if (state.canShowPanel(LayoutPanel.addons) &&
                      state.addons != null) ...{
                    SettingsPanelData(
                      name: 'Addons',
                      builder: addonsBuilder,
                    ),
                  },
                ],
              ),
            ),
        ],
      ),
    );
  }
}
