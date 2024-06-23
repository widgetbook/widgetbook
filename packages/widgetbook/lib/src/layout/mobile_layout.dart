import 'package:flutter/material.dart';

import '../settings/settings.dart';
import '../state/state.dart';
import 'base_layout.dart';

class MobileLayout extends StatelessWidget implements BaseLayout {
  const MobileLayout({
    super.key,
    required this.navigationBuilder,
    required this.addonsBuilder,
    required this.knobsBuilder,
    required this.argsBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) knobsBuilder;
  final List<Widget> Function(BuildContext context) argsBuilder;
  final Widget workbench;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    return PopScope(
      onPopInvoked: (didPop) async {
        // Check if a modal is open
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop(); // Close the modal
        } else {
          // Show a dialog asking if the user really wants to quit
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you really want to quit the app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          );

          if (shouldExit == true) {
            // Exit the app
            Navigator.of(context).pop(true);
          }
        }
      },
      child: Scaffold(
        key: ValueKey(state.isNext), // Rebuild when switching to next
        body: SafeArea(
          child: workbench,
        ),
        bottomNavigationBar: ExcludeSemantics(
          child: BottomNavigationBar(
            items: [
              const BottomNavigationBarItem(
                label: 'Navigation',
                icon: Icon(Icons.list_outlined),
              ),
              const BottomNavigationBarItem(
                label: 'Addons',
                icon: Icon(Icons.dashboard_customize_outlined),
              ),
              BottomNavigationBarItem(
                label: state.isNext ? 'Args' : 'Knobs',
                icon: const Icon(Icons.tune_outlined),
              ),
            ],
            onTap: (index) {
              showModalBottomSheet<void>(
                context: context,
                builder: (context) {
                  switch (index) {
                    case 0:
                      return ExcludeSemantics(
                        child: navigationBuilder(context),
                      );
                    case 1:
                      return ExcludeSemantics(
                        child: MobileSettingsPanel(
                          name: 'Addons',
                          builder: addonsBuilder,
                        ),
                      );
                    case 2:
                      return ExcludeSemantics(
                        child: state.isNext
                            ? MobileSettingsPanel(
                                name: 'Args',
                                builder: argsBuilder,
                              )
                            : MobileSettingsPanel(
                                name: 'Knobs',
                                builder: knobsBuilder,
                              ),
                      );
                    default:
                      return Container();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
