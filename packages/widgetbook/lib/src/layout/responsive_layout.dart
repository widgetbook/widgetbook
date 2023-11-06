import 'package:flutter/material.dart';

import '../layout/desktop_layout.dart';
import '../layout/mobile_layout.dart';
import '../navigation/navigation.dart';
import '../state/state.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    final addons = state.effectiveAddons!
        .map((addon) => addon.buildFields(context))
        .toList();

    final knobs = state.knobs.values //
        .map((knob) => knob.buildFields(context))
        .toList();

    final navigationPanel = NavigationPanel(
      initialPath: state.path,
      root: state.root,
      onNodeSelected: (node) {
        WidgetbookState.of(context).updatePath(node.path);
      },
    );

    final isMobile = MediaQuery.sizeOf(context).width < 800;

    return isMobile
        ? MobileLayout(
            navigation: navigationPanel,
            addons: addons,
            knobs: knobs,
            workbench: child,
          )
        : DesktopLayout(
            navigation: navigationPanel,
            addons: addons,
            knobs: knobs,
            workbench: child,
          );
  }
}
