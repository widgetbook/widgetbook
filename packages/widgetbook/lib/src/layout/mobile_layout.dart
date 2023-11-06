import 'package:flutter/material.dart';

import 'base_layout.dart';

class MobileLayout extends StatelessWidget implements BaseLayout {
  const MobileLayout({
    super.key,
    required this.addons,
    required this.knobs,
    required this.navigation,
    required this.workbench,
  });

  final List<Widget> addons;
  final List<Widget> knobs;
  final Widget navigation;
  final Widget workbench;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: workbench,
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
              label: 'Knobs',
              icon: Icon(Icons.tune_outlined),
            ),
          ],
          onTap: (index) {
            showModalBottomSheet<void>(
              context: context,
              builder: (context) {
                switch (index) {
                  case 0:
                    return navigation;
                  case 1:
                    return ListView.builder(
                      itemCount: addons.length,
                      itemBuilder: (context, index) => addons[index],
                    );
                  case 2:
                    return ListView.builder(
                      itemCount: knobs.length,
                      itemBuilder: (context, index) => knobs[index],
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
