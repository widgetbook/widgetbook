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
    required this.knobsBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) knobsBuilder;
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
            label: 'Knobs',
            icon: const Icon(Icons.tune_outlined),
          ),
        ],
        onTap: (index) {
          showModalBottomSheet<void>(
            context: context,
            builder: (context) {
              switch (index) {
                case 0:
                  return navigationBuilder(context);
                case 1:
                  return MobileSettingsPanel(
                    name: 'Addons',
                    builder: addonsBuilder,
                  );
                case 2:
                  return MobileSettingsPanel(
                    name: 'Knobs',
                    builder: knobsBuilder,
                  );
                default:
                  return Container();
              }
            },
          );
        },
      ),
    );
  }
}
