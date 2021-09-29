import 'package:flutter/material.dart';
import 'package:widgetbook/src/providers/device_provider.dart';
import 'package:widgetbook/src/widgets/device_item.dart';
import '../utils/extensions.dart';

class DeviceBar extends StatelessWidget {
  const DeviceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceProvider = DeviceProvider.of(context)!;
    var state = deviceProvider.state;
    return Row(
      children: [
        const Text('Device'),
        const SizedBox(
          width: 12,
        ),
        TextButton(
          onPressed: deviceProvider.previousDevice,
          style: TextButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            minimumSize: Size.zero,
            padding: const EdgeInsets.all(12),
          ),
          child: Icon(
            Icons.chevron_left,
            color: context.theme.hintColor,
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return DeviceItem(
              device: state.availableDevices[index],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 8,
            );
          },
          itemCount: state.availableDevices.length,
        ),
        TextButton(
          onPressed: deviceProvider.nextDevice,
          style: TextButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            minimumSize: Size.zero,
            padding: const EdgeInsets.all(12),
          ),
          child: Icon(
            Icons.chevron_right,
            color: context.theme.hintColor,
          ),
        ),
      ],
    );
  }
}
