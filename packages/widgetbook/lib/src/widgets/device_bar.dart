import 'package:flutter/material.dart';

import 'package:widgetbook/src/providers/device_provider.dart';
import 'package:widgetbook/src/widgets/device_item.dart';
import 'package:widgetbook/src/workbench/iteration_button.dart';
import 'package:widgetbook/src/workbench/multiselect_button.dart';

class DeviceBar extends StatelessWidget {
  const DeviceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceProvider = DeviceProvider.of(context)!;
    final state = deviceProvider.state;
    return Row(
      children: [
        IterationButton.left(
          onPressed: deviceProvider.previousDevice,
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
        IterationButton.right(
          onPressed: deviceProvider.nextDevice,
        ),
      ],
    );
  }
}
