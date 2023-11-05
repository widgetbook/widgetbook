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
    final isMobile = MediaQuery.sizeOf(context).width < 800;

    return isMobile
        ? MobileWidgetbookShell(child: child)
        : DesktopWidgetbookShell(child: child);
  }
}

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
  int _pointerCount = 0;
  bool isBottomBarVisible = true;

  void handlePointerDown(PointerDownEvent event) {
    setState(() {
      _pointerCount++;
    });

    if (_pointerCount == 4) {
      setState(() {
        isBottomBarVisible = !isBottomBarVisible;
      });
    }
  }

  void handlePointerUp(PointerUpEvent event) {
    if (_pointerCount == 0) {
      return;
    }
    setState(() {
      _pointerCount--;
    });

    if (_pointerCount == 0) {
      setState(() {
        isBottomBarVisible = !isBottomBarVisible;
      });

      print('_pointerCount: $_pointerCount');

      print('isBottomBarVisible: $isBottomBarVisible');
    }
  }

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
      bottomNavigationBar: isBottomBarVisible
          ? BottomNavigationBar(
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
            )
          : null,
      body: Listener(
        onPointerDown: handlePointerDown,
        onPointerUp: handlePointerUp,
        child: Container(
          // Content of the Widgetbook shell
          child: widget.child,
        ),
      ),
    );
  }
}
