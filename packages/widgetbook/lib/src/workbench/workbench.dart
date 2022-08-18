import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/navigation/preview_provider.dart';
import 'package:widgetbook/src/utils/utils.dart';
import 'package:widgetbook/src/workbench/preview.dart';
import 'package:widgetbook/src/workbench/workbench_controls.dart';

class Workbench<CustomTheme> extends StatefulWidget {
  const Workbench({
    Key? key,
  }) : super(key: key);

  @override
  State<Workbench<CustomTheme>> createState() => _WorkbenchState<CustomTheme>();
}

class _WorkbenchState<CustomTheme> extends State<Workbench<CustomTheme>> {
  final _overlayKey = GlobalKey<OverlayState>();
  final _layerLink = LayerLink();
  @override
  Widget build(BuildContext context) {
    final state = context.watch<PreviewProvider>().state;
    final addons = context.watch<AddOnProvider>().value;
    final useCase = state.selectedUseCase;
    return Nested(
      children: addons
          .map(
            (e) => SingleChildBuilder(
              builder: (context, child) => e.wrapperBuilder(context, child!),
            ),
          )
          .toList(),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WorkbenchControls<CustomTheme>(
                layerLink: _layerLink,
                overlayKey: _overlayKey,
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: Radii.defaultRadius,
                    color: context.colorScheme.surface,
                  ),
                  child: useCase == null
                      ? Container()
                      : Preview<CustomTheme>(useCase: useCase),
                ),
              ),
            ],
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Overlay(key: _overlayKey),
          ),
        ],
      ),
    );
  }
}
