import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/builder/provider/builder_provider.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/widgetbook.dart';

import 'renderer.dart';
import 'safe_boundaries.dart';

class Workbench extends StatelessWidget {
  const Workbench({
    super.key,
    required this.useCase,
  });

  final WidgetbookUseCase? useCase;

  @override
  Widget build(BuildContext context) {
    final appBuilder = context.watch<BuilderProvider>().value.appBuilder;

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
                useCaseBuilder: useCase!.builder,
              ),
      ),
    );
  }
}
