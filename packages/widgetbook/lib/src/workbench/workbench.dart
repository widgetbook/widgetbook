import 'package:flutter/material.dart';

import '../state/state.dart';
import 'addons_builder.dart';
import 'safe_boundaries.dart';

class Workbench extends StatelessWidget {
  const Workbench({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    return Scaffold(
      // Some addons require a Scaffold to work properly.
      body: SafeBoundaries(
        child: state.appBuilder(
          context,
          ColoredBox(
            // Background color for the area behind device frame if
            // the [DeviceFrameAddon] is used.
            color: Theme.of(context).scaffoldBackgroundColor,
            child: AddonsBuilder(
              addons: state.addons,
              child: Stack(
                // The Stack is used to loosen the constraints of
                // the UseCaseBuilder. Without the Stack, UseCaseBuilder
                // would expand to the whole size of the Workbench.
                children: [
                  Builder(
                    key: ValueKey(state.uri),
                    builder: (context) {
                      return WidgetbookState.of(context)
                              .story
                              ?.build(context) ??
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
