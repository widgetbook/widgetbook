import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../state/state.dart';
import '../theme/theme.dart';
import 'docs_preview.dart';
import 'safe_boundaries.dart';

/// The [Workbench] is the main widget that displays the current use case
/// in the context of the [WidgetbookState]. It is responsible for building
/// the use case and applying the necessary addons.
@internal
class Workbench extends StatelessWidget {
  const Workbench({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    if (state.docs != null) {
      return const DocsPreview();
    }

    final scenario = state.scenario;
    if (scenario != null) {
      return _WorkbenchWrapper(
        child: scenario.buildWithConfig(
          context,
          state.config,
        ),
      );
    }

    final story = state.story;
    if (story != null) {
      return _WorkbenchWrapper(
        child: story.buildWithConfig(
          context,
          state.config,
        ),
      );
    }

    return state.config.home;
  }
}

class _WorkbenchWrapper extends StatelessWidget {
  const _WorkbenchWrapper({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = WidgetbookTheme.of(context);

    return SafeBoundaries(
      child: ColoredBox(
        // This color is the default one used behind the child when the child
        // size doesn't fill the entire available space.
        // For example, when a viewport is used to simulate smaller devices,
        // this color will be used behind the viewport.
        color: theme.scaffoldBackgroundColor,
        child: child,
      ),
    );
  }
}
