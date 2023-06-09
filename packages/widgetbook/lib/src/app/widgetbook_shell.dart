import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';
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

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: ResizableWidget(
        children: [
          core.NavigationPanel(
            initialPath: state.path,
            directories: state.directories,
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
          const SizedBox(
            width: 400,
            child: SettingsPanel(),
          ),
        ],
        isHorizontalSeparator: false,
        isDisabledSmartHide: false,
        separatorColor: Colors.white24,
        separatorSize: 2,
        percentages: [0.2, 0.6, 0.2],
      ),
    );
  }
}
