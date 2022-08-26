import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon_panel.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';

class WorkbenchControls extends StatelessWidget {
  const WorkbenchControls({
    Key? key,
    required this.overlayKey,
    required this.layerLink,
  }) : super(key: key);

  final GlobalKey<OverlayState> overlayKey;
  final LayerLink layerLink;
  @override
  Widget build(BuildContext context) {
    final addons = context.watch<AddOnProvider>().value;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CompositedTransformTarget(
          link: layerLink,
          child: AddonPanel(
            plugins: addons,
            layerLink: layerLink,
            overlayKey: overlayKey,
          ),
        ),
      ],
    );
  }
}
