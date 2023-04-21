import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/builder/provider/builder_provider.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/navigation/providers/use_cases_provider.dart';
import 'package:widgetbook/src/routing/router.dart';
import 'package:widgetbook/src/workbench/preview.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

import '../styled_widgets/styled_widgets.dart';

class Workbench extends StatefulWidget {
  const Workbench({
    required this.queryParams,
    super.key,
  });

  final Map<String, String> queryParams;

  @override
  State<Workbench> createState() => _WorkbenchState();
}

class _WorkbenchState extends State<Workbench> {
  @override
  Widget build(BuildContext context) {
    final addons = context.watch<AddOnProvider>().value;
    final appBuilder = context.watch<BuilderProvider>().value.appBuilder;
    final state = context.watch<UseCasesProvider>().value;
    final useCaseBuilder = state.selectedUseCase?.builder;

    return StyledScaffold(
      body: MultiAddonBuilder(
        // Key is important here for correct rebuilds.
        key: ValueKey(widget.queryParams),
        addons: addons,
        builder: (_, addon, child) => addon.buildScope(
          widget.queryParams,
          child,
        ),
        onChanged: (setting) => context.goTo(
          queryParams: setting.toQueryParameter(),
        ),
        child: DecoratedBox(
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
        ),
      ),
    );
  }
}
