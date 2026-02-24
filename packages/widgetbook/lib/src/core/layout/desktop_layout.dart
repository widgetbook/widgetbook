import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../settings/settings_list.dart';
import '../state/state.dart';
import '../theme/theme.dart';
import 'base_layout.dart';

/// The [DesktopLayout] is a layout for desktop devices that allows
/// displaying the navigation, addons, knobs, and workbench in a
/// resizable layout.
@internal
class DesktopLayout extends StatelessWidget implements BaseLayout {
  const DesktopLayout({
    super.key,
    required this.navigationBuilder,
    required this.addonsBuilder,
    required this.argsBuilder,
    required this.scenarioInfoBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) argsBuilder;
  final Widget Function(BuildContext context) scenarioInfoBuilder;
  final Widget workbench;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    const kSidePanelPercentage = 0.2;
    const kWorkbenchPercentage = 1 - 2 * kSidePanelPercentage;
    final showNavigationPanel = state.canShowPanel(LayoutPanel.navigation);

    return ColoredBox(
      color: WidgetbookTheme.of(context).colorScheme.surface,
      child: ResizableLayout(
        items: [
          if (showNavigationPanel)
            ResizableLayoutItem(
              percentage: kSidePanelPercentage,
              builder: (context) => Card(
                child: navigationBuilder(context),
              ),
            ),
          ResizableLayoutItem(
            percentage: kWorkbenchPercentage,
            builder: (context) => workbench,
          ),
          ResizableLayoutItem(
            percentage: kSidePanelPercentage,
            builder: (context) {
              // React to changes when switching between scenarios and stories
              // to update the side panel content.
              return ListenableBuilder(
                listenable: state,
                builder: (context, child) {
                  final isScenario = state.scenario != null;
                  final showArgsPanel = state.canShowPanel(LayoutPanel.args);
                  final showAddonsPanel = state.canShowPanel(
                    LayoutPanel.addons,
                  );
                  final showSettingsPanel = showArgsPanel || showAddonsPanel;

                  if (isScenario) {
                    return Card(
                      child: scenarioInfoBuilder(context),
                    );
                  }

                  if (showSettingsPanel) {
                    return Card(
                      child: DefaultTabController(
                        length:
                            (showArgsPanel ? 1 : 0) + (showAddonsPanel ? 1 : 0),
                        child: Column(
                          children: [
                            TabBar(
                              tabs: [
                                if (showArgsPanel) const Tab(text: 'Args'),
                                if (showAddonsPanel) const Tab(text: 'Addons'),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  if (showArgsPanel) ...{
                                    SettingsList(
                                      name: 'Args',
                                      builder: argsBuilder,
                                    ),
                                  },
                                  if (showAddonsPanel) ...{
                                    SettingsList(
                                      name: 'Addons',
                                      builder: addonsBuilder,
                                    ),
                                  },
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

@internal
class ResizableLayoutItem {
  const ResizableLayoutItem({
    required this.percentage,
    required this.builder,
  });

  final double percentage;
  final WidgetBuilder builder;
}

/// An improved API for [ResizableWidget] that allows passing both percentage
/// and child in a single object, allowing to easily add or remove items.
/// Also distributes the remaining space equally among all items.
@internal
class ResizableLayout extends StatelessWidget {
  const ResizableLayout({super.key, required this.items});

  final List<ResizableLayoutItem> items;

  @override
  Widget build(BuildContext context) {
    final totalPercentage = items.fold(0.0, (sum, x) => sum + x.percentage);
    final remainingPercentage = 1 - totalPercentage;
    final extraPercentage = remainingPercentage / items.length;

    return ResizableWidget(
      separatorSize: 2,
      separatorColor: Colors.white24,
      percentages: items.map((x) => x.percentage + extraPercentage).toList(),
      children: items.map((x) => x.builder(context)).toList(),
    );
  }
}
