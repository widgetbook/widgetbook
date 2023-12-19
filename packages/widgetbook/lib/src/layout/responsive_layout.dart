import 'package:flutter/material.dart';

import '../../next.dart';
import '../layout/desktop_layout.dart';
import '../layout/mobile_layout.dart';
import '../navigation/navigation.dart';
import '../next/navigation/navigation_panel.dart';
import '../state/state.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  Widget buildNavigation(BuildContext context, bool isMobile) {
    final state = WidgetbookState.of(context);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: 'Next',
                icon: ExperimentalBadge(),
              ),
              Tab(text: 'V3'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                NextNavigationPanel(
                  root: state.root,
                ),
                NavigationPanel(
                  initialPath: state.path,
                  root: state.v3Root,
                  onNodeSelected: (node) {
                    WidgetbookState.of(context)
                        .updatePath(node.path); // Fresh context

                    if (isMobile) {
                      Navigator.pop(context); // Close the modal
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildAddons(BuildContext context) {
    final state = WidgetbookState.of(context);

    return state.addons == null
        ? []
        : state.effectiveAddons!
            .map((addon) => addon.buildFields(context))
            .toList();
  }

  List<Widget> buildArgs(BuildContext context) {
    final state = WidgetbookState.of(context);
    final story = state.story;

    return story?.args.safeList //
            .map((e) => e.buildFields(context))
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery.sizeOf is not backwards compatible with Flutter < 3.10.0
    final isMobile = MediaQuery.of(context).size.width < 800;

    return isMobile
        ? MobileLayout(
            navigationBuilder: (context) => buildNavigation(context, true),
            addonsBuilder: buildAddons,
            argsBuilder: buildArgs,
            workbench: child,
          )
        : DesktopLayout(
            navigationBuilder: (context) => buildNavigation(context, false),
            addonsBuilder: buildAddons,
            argsBuilder: buildArgs,
            workbench: child,
          );
  }
}
