import 'package:flutter/material.dart';

import '../settings/settings.dart';
import 'base_layout.dart';

class MobileLayout extends StatelessWidget implements BaseLayout {
  const MobileLayout({
    super.key,
    required this.navigationBuilder,
    required this.addonsBuilder,
    required this.argsBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) argsBuilder;
  final Widget workbench;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const BottomNavigationBarItem(
              label: 'Args',
              icon: Icon(Icons.tune_outlined),
            ),
          ],
          onTap: (index) {
            showModalBottomSheet<void>(
              context: context,
              builder: (context) => switch (index) {
                0 => ExcludeSemantics(
                    child: navigationBuilder(context),
                  ),
                1 => ExcludeSemantics(
                    child: SettingsList(
                      name: 'Addons',
                      builder: addonsBuilder,
                    ),
                  ),
                2 => ExcludeSemantics(
                    child: SettingsList(
                      name: 'Args',
                      builder: argsBuilder,
                    ),
                  ),
                _ => Container(),
              },
            );
          },
        ),
      ),
    );
  }
}
