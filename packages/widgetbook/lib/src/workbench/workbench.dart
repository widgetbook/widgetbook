import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';

import '../state/state.dart';
import 'renderer.dart';
import 'safe_boundaries.dart';

class Workbench extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBuilder = WidgetbookScope.of(context).appBuilder;
    final useCase = WidgetbookScope.of(context).useCase;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: Radii.defaultRadius,
        color: Theme.of(context).colorScheme.surface,
      ),
      child: SafeBoundaries(
        child: useCase == null
            ? Container()
            : Renderer(
                appBuilder: appBuilder,
                useCaseBuilder: useCase.builder,
              ),
      ),
    );
  }
}
