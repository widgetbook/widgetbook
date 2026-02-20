import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../settings/settings.dart';
import 'base_layout.dart';

/// The [MobileLayout] is a layout for mobile devices that allows
/// displaying the navigation, addons and knobs in a bottom-navigation layout.
@internal
class MobileLayout extends StatelessWidget implements BaseLayout {
  const MobileLayout({
    super.key,
    required this.navigationBuilder,
    required this.addonsBuilder,
    required this.argsBuilder,
    required this.scenarioInfoBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) argsBuilder;
  final Widget Function(BuildContext context) scenarioInfoBuilder;
  final Widget workbench;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: workbench,
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          const BottomNavigationBarItem(
            label: 'Scenario Info',
            icon: Icon(Icons.info_outline),
          ),
        ],
        onTap: (index) {
          showModalBottomSheet<void>(
            context: context,
            builder: (context) => switch (index) {
              0 => navigationBuilder(context),
              1 => SettingsList(
                name: 'Addons',
                builder: addonsBuilder,
              ),
              2 => SettingsList(
                name: 'Args',
                builder: argsBuilder,
              ),
              3 => scenarioInfoBuilder(context),
              _ => Container(),
            },
          );
        },
      ),
    );
  }
}
