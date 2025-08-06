import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../../widgetbook_theme.dart';
import '../common/common.dart';
import 'device_frame_setting.dart';
import 'none_device.dart';

/// @nodoc
@Deprecated(
  'The [DeviceFrameAddon] is deprecated and will be removed in a future version. '
  'Please use the [ViewportAddon] instead. '
  'More info: https://docs.widgetbook.io/addons/viewport-addon',
)
class DeviceFrameAddon extends WidgetbookAddon<DeviceFrameSetting> {
  /// @nodoc
  DeviceFrameAddon({
    required List<DeviceInfo> devices,
    this.initialDevice = NoneDevice.instance,
  }) : assert(
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

  /// @nodoc
  final DeviceInfo initialDevice;

  /// @nodoc
  final List<DeviceInfo> devices;

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<DeviceInfo>(
        name: 'name',
        values: devices,
        initialValue: initialDevice,
        labelBuilder: (device) => device.name,
      ),
      ObjectDropdownField<Orientation>(
        name: 'orientation',
        values: Orientation.values,
        initialValue: Orientation.portrait,
        labelBuilder:
            (orientation) =>
                orientation.name.substring(0, 1).toUpperCase() +
                orientation.name.substring(1),
      ),
      ObjectDropdownField<bool>(
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
          screen: ColoredBox(
            color: WidgetbookTheme.of(context).scaffoldBackgroundColor,
            child: Navigator(
              // A navigator below the device frame is necessary to make the
              // popup routes (e.g. dialogs and bottom sheets) work within the
              // device frame, otherwise they would use the navigator from the
              // app builder, causing these routes to fill the whole workbench
              // and not just the device frame.
              onGenerateRoute:
                  (_) => PageRouteBuilder(
                    pageBuilder:
                        (context, _, __) =>
                            setting.hasFrame
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
