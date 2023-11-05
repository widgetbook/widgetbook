import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';
import '../navigation/navigation.dart';
import '../settings/settings.dart';
import '../state/state.dart';

class DesktopWidgetbookShell extends StatelessWidget {
  const DesktopWidgetbookShell({super.key, required this.child});

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
          ExcludeSemantics(
            child: NavigationPanel(
              initialPath: state.path,
              root: state.root,
              onNodeSelected: (node) {
                WidgetbookState.of(context).updatePath(node.path);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
            ),
            child: child,
          ),
          ExcludeSemantics(
            child: SettingsPanel(
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
          ),
        ],
      ),
    );
  }
}
