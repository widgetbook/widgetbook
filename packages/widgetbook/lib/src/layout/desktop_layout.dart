import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../settings/settings.dart';
import '../state/state.dart';
import '../widgetbook_theme.dart';
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
    required this.knobsBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) knobsBuilder;
  final Widget workbench;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    const kSidePanelPercentage = 0.2;
    const kWorkbenchPercentage = 1 - 2 * kSidePanelPercentage;

    final showNavigationPanel = state.canShowPanel(LayoutPanel.navigation);
    final showSettingsPanel =
        state.canShowPanel(LayoutPanel.addons) ||
        state.canShowPanel(LayoutPanel.knobs);

    return ColoredBox(
      color: WidgetbookTheme.of(context).colorScheme.surface,
      child: ResizableLayout(
        items: [
          if (showNavigationPanel)
            ResizableLayoutItem(
              percentage: kSidePanelPercentage,
              child: Card(
                child: navigationBuilder(context),
              ),
            ),
          ResizableLayoutItem(
            percentage: kWorkbenchPercentage,
            child: workbench,
          ),
          if (showSettingsPanel)
            ResizableLayoutItem(
              percentage: kSidePanelPercentage,
              child: Card(
                child: SettingsPanel(
                  settings: [
                    if (state.canShowPanel(LayoutPanel.knobs)) ...{
                      SettingsPanelData(
                        name: 'Knobs',
                        builder: knobsBuilder,
                      ),
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
    required this.child,
  });

  final double percentage;
  final Widget child;
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
      children: items.map((x) => x.child).toList(),
    );
  }
}
