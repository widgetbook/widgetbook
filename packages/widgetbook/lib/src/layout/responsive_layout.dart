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

  Widget buildNavigation(BuildContext context, bool isMobile) {
    final state = WidgetbookState.of(context);

    return NavigationPanel(
      initialPath: state.path,
      root: state.root,
      onNodeSelected: (node) {
        WidgetbookState.of(context).updatePath(node.path); // Fresh context

        if (isMobile) {
          Navigator.pop(context); // Close the modal
        }
      },
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

  List<Widget> buildKnobs(BuildContext context) {
    final state = WidgetbookState.of(context);

    return state.knobs.values //
        .map((knob) => knob.buildFields(context))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 800;

    return isMobile
        ? MobileLayout(
            navigationBuilder: (context) => buildNavigation(context, true),
            addonsBuilder: buildAddons,
            knobsBuilder: buildKnobs,
            workbench: child,
          )
        : DesktopLayout(
            navigationBuilder: (context) => buildNavigation(context, false),
            addonsBuilder: buildAddons,
            knobsBuilder: buildKnobs,
            workbench: child,
          );
  }
}
