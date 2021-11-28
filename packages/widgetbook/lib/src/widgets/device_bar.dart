import 'package:flutter/material.dart';

import 'package:widgetbook/src/providers/device_provider.dart';
import 'package:widgetbook/src/utils/extensions.dart';
import 'package:widgetbook/src/widgets/device_item.dart';

class DeviceBar extends StatelessWidget {
  const DeviceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceProvider = DeviceProvider.of(context)!;
    final state = deviceProvider.state;
    return Row(
      children: [
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
        const SizedBox(
          width: 40,
        ),
        Tooltip(
          message: 'Change Orientation',
          child: TextButton(
            onPressed: deviceProvider.toggleOrientation,
            style: TextButton.styleFrom(
              splashFactory: InkRipple.splashFactory,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90)),
              minimumSize: Size.zero,
              padding: const EdgeInsets.all(12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.sync,
                  color: state.orientation == Orientation.landscape
                      ? context.colorScheme.primary
                      : context.theme.hintColor,
                  size: 30,
                ),
                Icon(
                  state.orientation == Orientation.portrait
                      ? Icons.stay_current_portrait
                      : Icons.stay_current_landscape,
                  color: state.orientation == Orientation.landscape
                      ? context.colorScheme.primary
                      : context.theme.hintColor,
                  size: 12,
                ),
              ],
            ),
          ),
        ),
        Tooltip(
          message: 'Show Keyboard',
          child: TextButton(
            onPressed: deviceProvider.toggleKeyBoard,
            style: TextButton.styleFrom(
              splashFactory: InkRipple.splashFactory,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90),
              ),
              minimumSize: Size.zero,
              padding: const EdgeInsets.all(12),
            ),
            child: Icon(
              Icons.keyboard,
              color: state.showKeyboard
                  ? context.colorScheme.primary
                  : context.theme.hintColor,
            ),
          ),
        ),
        Tooltip(
          message: 'Show Device Frame',
          child: Column(
            children: [
              Switch(
                activeColor: context.colorScheme.primary,
                value: state.isFrameVisible,
                onChanged: (_) {
                  deviceProvider.toggleFrameVisibility();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
