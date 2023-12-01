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

    return Scaffold(
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
    );
  }
}
