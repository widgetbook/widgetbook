import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'zoom_setting.dart';

class ZoomAddon extends WidgetbookAddon<ZoomSetting> {
  ZoomAddon({double? initialScale})
      : super(
          name: 'Zoom',
          initialSetting: ZoomSetting(initialScale: initialScale),
        );

  @override
  List<Field> get fields => []; // No fields for now

  @override
  ZoomSetting valueFromQueryGroup(Map<String, String> group) {
    return ZoomSetting(
      initialScale: double.tryParse(group['scale'] ?? '1.0') ?? 1.0,
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    ZoomSetting setting,
  ) {
    return Column(
      children: [
        ValueListenableBuilder<double>(
          valueListenable: setting.scaleNotifier,
          builder: (context, zoomValue, child) {
            return Text('${zoomValue.toStringAsFixed(2)} zoom');
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: setting.zoomIn,
              child: const Text('Zoom In'),
            ),
            ElevatedButton(
              onPressed: setting.zoomOut,
              child: const Text('Zoom Out'),
            ),
            ElevatedButton(
              onPressed: setting.reset,
              child: const Text('Reset Zoom'),
            ),
          ],
        ),
        Expanded(
          child: ValueListenableBuilder<double>(
            valueListenable: setting.scaleNotifier,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: child,
          ),
        ),
      ],
    );
  }
}
