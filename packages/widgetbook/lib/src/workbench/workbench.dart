import 'package:flutter/material.dart';

import '../addons/addons.dart';
import '../fields/fields.dart';
import '../state/state.dart';
import 'safe_boundaries.dart';
import 'use_case_builder.dart';

class Workbench extends StatelessWidget {
  const Workbench({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final useCase = state.useCase;

    if (useCase == null) {
      return state.home;
    }

    return Scaffold(
      // Some addons require a Scaffold to work properly.
      body: SafeBoundaries(
        child: state.appBuilder(
          context,
          ColoredBox(
            // Background color for the area behind device frame if
            // the [DeviceFrameAddon] is used.
            color: Theme.of(context).scaffoldBackgroundColor,
            child: MultiAddonBuilder(
              addons: state.addons,
              builder: (context, addon, child) {
                final state = WidgetbookState.of(context);
                final groupMap = FieldCodec.decodeQueryGroup(
                  state.queryParams[addon.groupName],
                );

                final newSetting = addon.valueFromQueryGroup(groupMap);

                return addon.buildUseCase(
                  context,
                  child,
                  newSetting,
                );
              },
              child: Stack(
                // The Stack is used to loosen the constraints of
                // the UseCaseBuilder. Without the Stack, UseCaseBuilder
                // would expand to the whole size of the Workbench.
                children: [
                  UseCaseBuilder(
                    key: ValueKey(state.uri),
                    builder: (context) {
                      final state = WidgetbookState.of(context);
                      final useCase = state.useCase;

                      return useCase?.build(context) ?? const SizedBox.shrink();
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
