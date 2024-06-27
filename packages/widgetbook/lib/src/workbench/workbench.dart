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

    return Scaffold(
      // Some addons require a Scaffold to work properly.
      body: SafeBoundaries(
        child: ColoredBox(
          // Background color for the area behind device frame if
          // the [DeviceFrameAddon] is used. This has to be here instead of
          // inside the [DeviceFrameAddon] because the state.builder provides
          // a new [WidgetsApp] that will have its own theme.
          color: Theme.of(context).scaffoldBackgroundColor,
          child: state.builder(
            context,
            (context, child) => MultiAddonBuilder(
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
              child: child,
            ),
            Stack(
              // The Stack is used to loosen the constraints of
              // the UseCaseBuilder. Without the Stack, UseCaseBuilder
              // would expand to the whole size of the Workbench.
              children: [
                UseCaseBuilder(
                  key: ValueKey(state.uri),
                  builder: (context) {
                    return WidgetbookState.of(context)
                            .useCase
                            ?.build(context) ??
                        const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
