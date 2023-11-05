import 'package:flutter/material.dart';
import '../navigation/navigation.dart';
import '../settings/settings.dart';
import '../state/state.dart';

class MobileWidgetbookShell extends StatefulWidget {
  const MobileWidgetbookShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<MobileWidgetbookShell> createState() => MobileWidgetbookShellState();
}

class MobileWidgetbookShellState extends State<MobileWidgetbookShell> {
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
                NavigationPanel(
                  initialPath: state.path,
                  root: state.root,
                  onNodeSelected: (node) {
                    WidgetbookState.of(context).updatePath(node.path);
                  },
                ),
              );
              break;
            case 1:
              _showModalBottomSheet(
                context,
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
                  ],
                ),
              );
              break;
            case 2:
              _showModalBottomSheet(
                context,
                SettingsPanel(
                  settings: [
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
              break;
          }
        },
      ),
      body: Container(
        // Content of the Widgetbook shell
        child: widget.child,
      ),
    );
  }
}
