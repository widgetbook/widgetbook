import 'package:flutter/material.dart';

import '../layout/desktop_layout.dart';
import '../layout/mobile_layout.dart';
import '../next/navigation/navigation_panel.dart';
import '../state/state.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  Widget buildNavigation(BuildContext context, bool isMobile) {
    return NextNavigationPanel(
      root: WidgetbookState.of(context).root,
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
