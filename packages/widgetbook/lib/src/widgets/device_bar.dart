import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook/src/widgets/device_item.dart';
import 'package:widgetbook/src/cubit/device/device_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/extensions.dart';

class DeviceBar extends StatelessWidget {
  const DeviceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCubit, DeviceState>(
      builder: (context, state) {
        return Row(children: [
          Text('Device'),
          SizedBox(
            width: 12,
          ),
          TextButton(
            onPressed: context.read<DeviceCubit>().previousDevice,
            style: TextButton.styleFrom(
              splashFactory: InkRipple.splashFactory,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90)),
              minimumSize: Size.zero,
              padding: const EdgeInsets.all(12),
            ),
            child: Icon(
              FontAwesomeIcons.chevronLeft,
              color: context.theme.hintColor,
              size: 16,
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
              return SizedBox(
                width: 8,
              );
            },
            itemCount: state.availableDevices.length,
          ),
          TextButton(
            onPressed: context.read<DeviceCubit>().nextDevice,
            style: TextButton.styleFrom(
              splashFactory: InkRipple.splashFactory,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90)),
              minimumSize: Size.zero,
              padding: const EdgeInsets.all(12),
            ),
            child: Icon(
              FontAwesomeIcons.chevronRight,
              color: context.theme.hintColor,
              size: 16,
            ),
          ),
        ]);
      },
    );
  }
}
