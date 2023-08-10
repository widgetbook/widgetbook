import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../navigation/navigation.dart';
import '../settings/settings.dart';
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
          NavigationPanel(
            initialPath: state.path,
            root: state.root,
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
          SettingsPanel(
            settings: [
              if (state.addons != null) ...{
                SettingsPanelData(
                  name: 'Addons',
                  builder: (context) => WidgetbookState.of(context)
                      .addons!
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
        ],
      ),
    );
  }
}
