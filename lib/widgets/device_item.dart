import 'package:flutter/material.dart';
import 'package:widgetbook/cubit/device/device_cubit.dart';
import 'package:widgetbook/models/device.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/extensions.dart';

class DeviceItem extends StatelessWidget {
  final Device device;
  const DeviceItem({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCubit, DeviceState>(
      builder: (context, state) {
        bool isCurrent = device == state.currentDevice;
        return GestureDetector(
          onTap: () {
            context.read<DeviceCubit>().selectDevice(
                  device,
                );
          },
          child: buildTooltip(
            context: context,
            isCurrent: isCurrent,
          ),
        );
      },
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
          FontAwesomeIcons.clock,
          color: color,
        );
      case DeviceType.mobile:
        return Icon(
          FontAwesomeIcons.mobile,
          color: color,
        );
      case DeviceType.tablet:
        return Icon(
          FontAwesomeIcons.tablet,
          color: color,
        );
      case DeviceType.desktop:
        return Icon(
          FontAwesomeIcons.desktop,
          color: color,
        );
      case DeviceType.unknown:
        return Icon(
          FontAwesomeIcons.question,
          color: color,
        );
    }
  }
}
