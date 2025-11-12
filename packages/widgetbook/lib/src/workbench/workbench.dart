import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../core/core.dart';
import '../state/state.dart';
import '../theme/theme.dart';
import '../utils.dart';
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

    final component = state.component;
    if (state.path?.endsWith('/Docs') == true && component != null) {
      return const DocsPreview();
    }

    final story = state.story;
    if (story == null) {
      return state.config.home;
    }

    final theme = WidgetbookTheme.of(context);

    return Scaffold(
      // Some addons require a Scaffold to work properly.
      body: SafeBoundaries(
        child: state.config.appBuilder(
          context,
          ColoredBox(
            // Background color for the area behind device frame if
            // the [DeviceFrameAddon] is used.
            color: theme.scaffoldBackgroundColor,
            child: NestedBuilder<Addon>(
              items: state.config.addons ?? [],
              builder: (context, addon, child) => addon.build(context, child),
              child: Stack(
                // The Stack is used to loosen the constraints of
                // the UseCaseBuilder. Without the Stack, UseCaseBuilder
                // would expand to the whole size of the Workbench.
                children: [
                  Builder(
                    key: ValueKey(state.uri),
                    builder: (context) {
                      // Get a fresh state that has updated addons,
                      // as the `state` variable from above might
                      // be outdated.
                      final state = WidgetbookState.of(context);

                      return state.story?.build(context) ??
                          const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
