import 'package:flutter/material.dart';
import '../settings/settings.dart';
import '../state/state.dart';
import 'shell_mixin.dart';

class MobileWidgetbookShell extends StatelessWidget with WidgetbookShellMixin {
  const MobileWidgetbookShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Navigation',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_customize_outlined),
            label: 'Addons',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.tune_outlined),
            label: 'Knobs',
          ),
        ],
        onTap: (index) {
          Widget panel;
          switch (index) {
            case 0:
              panel = buildNavigationPanel(context, state);
              break;
            case 1:
              panel =
                  SettingsPanel(settings: [buildAddonsPanel(context, state)]);
              break;
            case 2:
              panel =
                  SettingsPanel(settings: [buildKnobsPanel(context, state)]);
              break;
            default:
              throw Exception('Invalid index');
          }
          showModalBottomSheet<void>(
            context: context,
            builder: (context) => panel,
          );
        },
      ),
      body: Container(
        // Content of the Widgetbook shell
        child: child,
      ),
    );
  }
}
