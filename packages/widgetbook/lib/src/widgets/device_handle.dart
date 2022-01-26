import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/devices/devices.dart';
import 'package:widgetbook/src/multi_render_handle.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

class DeviceHandle extends ConsumerWidget {
  const DeviceHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbench = ref.read(workbenchProvider.notifier);
    return MultiRenderHandle<Device>(
      multiRender: MultiRender.devices,
      items: ref.read(devicesProvider).devices,
      buildItem: (Device e) => SelectionItem(
        iconData: buildIcon(e.type),
        tooltip: e.name,
        selectedItem: ref.watch(workbenchProvider).device,
        item: e,
        onPressed: () {
          workbench.changedDevice(e);
        },
      ),
      onPreviousPressed: workbench.previousDevice,
      onNextPressed: workbench.nextDevice,
    );
  }

  IconData buildIcon(DeviceType type) {
    switch (type) {
      case DeviceType.watch:
        return Icons.watch;
      case DeviceType.mobile:
        return Icons.smartphone;
      case DeviceType.tablet:
        return Icons.tablet;
      case DeviceType.desktop:
        return Icons.desktop_windows;
      case DeviceType.unknown:
        return Icons.quiz;
    }
  }
}
