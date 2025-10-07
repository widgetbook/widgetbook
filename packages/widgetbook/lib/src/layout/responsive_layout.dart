import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../layout/desktop_layout.dart';
import '../layout/mobile_layout.dart';
import '../navigation/navigation.dart';
import '../state/state.dart';

/// The [ResponsiveLayout] adapts the layout based on the screen size.
/// It uses [MobileLayout] for mobile devices and [DesktopLayout] for
/// larger screens.
@internal
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
      header: state.header,
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

    return state
        .knobs
        .values //
        .map((knob) => knob.buildFields(context))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Force desktop mode if `panels` query param is set.
    // This is useful for when Widgetbook is used in docs, and users don't
    // want the bottom navigation bar to be shown in the embedding.
    final isEmbedded = WidgetbookState.of(context).panels != null;

    // MediaQuery.sizeOf is not backwards compatible with Flutter < 3.10.0
    //
    // 840 is "Expanded" or "Tablet in landscape", "Desktop", ...
    // See: https://m3.material.io/foundations/layout/applying-layout/window-size-classes#2bb70e22-d09b-4b73-9c9f-9ef60311ccc8
    final isMobile = MediaQuery.of(context).size.width < 840;

    return isMobile && !isEmbedded
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
