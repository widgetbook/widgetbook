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

  void _showModalBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            label: 'Navigation',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Addons',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Knobs',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              _showModalBottomSheet(
                context,
                buildNavigationPanel(context, state),
              );
              break;
            case 1:
              _showModalBottomSheet(
                context,
                SettingsPanel(settings: [buildAddonsPanel(context, state)]),
              );
              break;
            case 2:
              _showModalBottomSheet(
                context,
                SettingsPanel(settings: [buildKnobsPanel(context, state)]),
              );
              break;
          }
        },
      ),
      body: Container(
        // Content of the Widgetbook shell
        child: child,
      ),
    );
  }
}
