import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/device.dart';
import 'package:widgetbook/src/providers/device_provider.dart';
import '../utils/extensions.dart';

class DeviceItem extends StatelessWidget {
  final Device device;
  const DeviceItem({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceProvider = DeviceProvider.of(context)!;
    var state = deviceProvider.state;
    bool isCurrent = device == state.currentDevice;
    return GestureDetector(
      onTap: () {
        deviceProvider.selectDevice(
          device,
        );
      },
      child: buildTooltip(
        context: context,
        isCurrent: isCurrent,
      ),
    );
  }

  Widget buildTooltip(
      {required BuildContext context, required bool isCurrent}) {
    return Tooltip(
      child: buildIcon(
        device.type,
        isCurrent ? context.colorScheme.primary : context.theme.hintColor,
      ),
      message: device.name,
    );
  }

  Widget buildIcon(DeviceType type, Color color) {
    switch (type) {
      case DeviceType.watch:
        return Icon(
          Icons.watch,
          color: color,
        );
      case DeviceType.mobile:
        return Icon(
          Icons.smartphone,
          color: color,
        );
      case DeviceType.tablet:
        return Icon(
          Icons.tablet,
          color: color,
        );
      case DeviceType.desktop:
        return Icon(
          Icons.desktop_windows,
          color: color,
        );
      case DeviceType.unknown:
        return Icon(
          Icons.quiz,
          color: color,
        );
    }
  }
}
