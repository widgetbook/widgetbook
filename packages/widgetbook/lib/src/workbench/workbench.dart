import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/builder/provider/builder_provider.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/navigation/preview_provider.dart';
import 'package:widgetbook/src/utils/utils.dart';
import 'package:widgetbook/src/workbench/preview.dart';
import 'package:widgetbook/src/workbench/workbench_controls.dart';

class Workbench extends StatefulWidget {
  const Workbench({
    super.key,
  });

  @override
  State<Workbench> createState() => _WorkbenchState();
}

class _WorkbenchState extends State<Workbench> {
  final _overlayKey = GlobalKey<OverlayState>();
  final _layerLink = LayerLink();
  @override
  Widget build(BuildContext context) {
    final appBuilder = context.watch<BuilderProvider>().value.appBuilder;
    final state = context.watch<PreviewProvider>().state;
    final useCase = state.selectedUseCase;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WorkbenchControls(
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
                    : Preview(
                        useCase: useCase,
                        appBuilder: appBuilder,
                      ),
              ),
            ),
          ],
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(key: _overlayKey),
        ),
      ],
    );
  }
}
