import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/builder/provider/builder_provider.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/navigation/providers/use_cases_provider.dart';
import 'package:widgetbook/src/workbench/preview.dart';

class Workbench extends StatefulWidget {
  const Workbench({
    super.key,
  });

  @override
  State<Workbench> createState() => _WorkbenchState();
}

class _WorkbenchState extends State<Workbench> {
  @override
  Widget build(BuildContext context) {
    final appBuilder = context.watch<BuilderProvider>().value.appBuilder;
    final state = context.watch<UseCasesProvider>().state;
    final useCaseBuilder = state.selectedUseCase?.builder;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: Radii.defaultRadius,
        color: Theme.of(context).colorScheme.surface,
      ),
      child: useCaseBuilder == null
          ? Container()
          : Preview(
              useCaseBuilder: useCaseBuilder,
              appBuilder: appBuilder,
            ),
    );
  }
}
