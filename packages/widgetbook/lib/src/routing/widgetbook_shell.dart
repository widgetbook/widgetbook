import 'dart:math';

import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../navigation/navigation.dart';
import '../settings/settings.dart';
import '../state/state.dart';

class WidgetbookShell extends StatelessWidget {
  const WidgetbookShell({
    super.key,
    required this.child,
    this.showLeftPanel = true,
    this.showRightPanel = true,
  });

  final Widget child;
  final bool showLeftPanel;
  final bool showRightPanel;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final children = <Widget>[];
    final percentages = <double>[];

    if (showLeftPanel) {
      children.add(
        NavigationPanel(
          initialPath: state.path,
          root: state.root,
          onNodeSelected: (node) {
            WidgetbookState.of(context).updatePath(node.path);
          },
        ),
      );
      percentages.add(0.2);
    }

    children.add(
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
        ),
        child: child,
      ),
    );
    percentages.add(0.6);

    if (showRightPanel) {
      children.add(
        SettingsPanel(
          settings: [
            if (state.addons != null) ...{
              SettingsPanelData(
                name: 'Addons',
                builder: (context) => WidgetbookState.of(context)
                    .effectiveAddons!
                    .map((addon) => addon.buildFields(context))
                    .toList(),
              ),
            },
            SettingsPanelData(
              name: 'Knobs',
              builder: (context) => WidgetbookState.of(context)
                  .knobs
                  .values
                  .map((knob) => knob.buildFields(context))
                  .toList(),
            ),
          ],
        ),
      );
      percentages.add(0.2);
    }

    final sum = percentages.reduce((a, b) => a + b);
    if (sum != 1) {
      if (percentages.length == 1) {
        // If there's only one item in the list, set its percentage to 1
        percentages[0] = 1;
      } else {
        // Find the index of the larger percentage
        final maxIndex = percentages.indexOf(percentages.reduce(max));
        // Adjust the largest percentage to fill the remaining space
        percentages[maxIndex] = 1 - (sum - percentages[maxIndex]);
      }
    }

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: ResizableWidget(
        key: ValueKey('$showLeftPanel-$showRightPanel'),
        separatorSize: 2,
        percentages: percentages,
        separatorColor: Colors.white24,
        children: children,
      ),
    );
  }
}
