import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'device_frame_setting.dart';
import 'none_device.dart';

/// A [WidgetbookAddon] for changing the active device/frame. It's based on
/// the [`device_frame`](https://pub.dev/packages/device_frame) package.
class DeviceFrameAddon extends WidgetbookAddon<DeviceFrameSetting> {
  DeviceFrameAddon({
    required List<DeviceInfo> devices,
    this.initialDevice = NoneDevice.instance,
  })  : assert(
          devices.isNotEmpty,
          'devices cannot be empty',
        ),
        assert(
          initialDevice == NoneDevice.instance ||
              devices.contains(initialDevice),
          'initialDevice must be in devices',
        ),
        this.devices = [NoneDevice.instance, ...devices],
        super(
          name: 'Device',
        );

  final DeviceInfo initialDevice;
  final List<DeviceInfo> devices;

  @override
  List<Field> get fields {
    return [
      ListField<DeviceInfo>(
        name: 'name',
        values: devices,
        initialValue: initialDevice,
        labelBuilder: (device) => device.name,
      ),
      ListField<Orientation>(
        name: 'orientation',
        values: Orientation.values,
        initialValue: Orientation.portrait,
        labelBuilder: (orientation) =>
            orientation.name.substring(0, 1).toUpperCase() +
            orientation.name.substring(1),
      ),
      ListField<bool>(
        name: 'frame',
        values: [false, true],
        initialValue: true,
        labelBuilder: (hasFrame) => hasFrame ? 'Device Frame' : 'None',
      ),
    ];
  }

  @override
  DeviceFrameSetting valueFromQueryGroup(Map<String, String> group) {
    return DeviceFrameSetting(
      device: valueOf('name', group)!,
      orientation: valueOf('orientation', group)!,
      hasFrame: valueOf('frame', group)!,
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    DeviceFrameSetting setting,
  ) {
    if (setting.device is NoneDevice) {
      return child;
    }

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: DeviceFrame(
          orientation: setting.orientation,
          device: setting.device,
          isFrameVisible: setting.hasFrame,
          // A navigator below the device frame is necessary to make
          // the popup routes (e.g. dialogs and bottom sheets) work within
          // the device frame, otherwise they would use the navigator from
          // the app builder, causing these routes to fill the whole
          // workbench and not just the device frame.
          screen: Navigator(
            onGenerateRoute: (_) => PageRouteBuilder(
              pageBuilder: (context, _, __) => ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: setting.hasFrame
                    ? child
                    : SafeArea(
                        child: child,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
