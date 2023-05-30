import 'package:flutter/material.dart';

import '../addons/addons.dart';
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
            return addon.buildUseCase(
              context,
              child,
            );
          },
          child: Scaffold(
            body: state.useCase!.builder(context),
          ),
        ),
      ),
    );
  }
}
