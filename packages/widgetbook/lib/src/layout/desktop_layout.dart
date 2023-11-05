import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';
import '../settings/settings.dart';
import '../state/state.dart';
import 'shell_mixin.dart';

class DesktopWidgetbookShell extends StatelessWidget with WidgetbookShellMixin {
  const DesktopWidgetbookShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final addonsPanelData = buildAddonsPanel(context, state);
    final knobsPanelData = buildKnobsPanel(context, state);
    final settings = [addonsPanelData, knobsPanelData];

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: ResizableWidget(
        separatorSize: 2,
        percentages: [0.2, 0.6, 0.2],
        separatorColor: Colors.white24,
        children: [
          ExcludeSemantics(child: buildNavigationPanel(context, state)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: child,
          ),
          ExcludeSemantics(
            child: SettingsPanel(settings: settings),
          ),
        ],
      ),
    );
  }
}
