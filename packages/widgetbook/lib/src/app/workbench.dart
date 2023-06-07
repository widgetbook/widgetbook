import 'package:flutter/material.dart';

import '../addons/addons.dart';
import '../fields/fields.dart';
import '../state/state.dart';
import 'safe_boundaries.dart';

class Workbench extends StatelessWidget {
  const Workbench({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    if (state.useCase == null) {
      return const SizedBox.shrink();
    }

    return SafeBoundaries(
      child: state.appBuilder(
        context,
        MultiAddonBuilder(
          addons: state.addons,
          builder: (context, addon, child) {
            final state = WidgetbookState.of(context);
            final groupMap = FieldCodec.decodeQueryGroup(
              state.queryParams[addon.slugName],
            );

            final newSetting = addon.settingFromQueryGroup(groupMap);

            return addon.buildUseCase(
              context,
              child,
              newSetting,
            );
          },
          child: Scaffold(
            body: Builder(
              key: ValueKey(state.uri),
              builder: state.useCase!.builder,
            ),
          ),
        ),
      ),
    );
  }
}
