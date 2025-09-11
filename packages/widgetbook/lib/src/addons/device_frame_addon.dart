import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/widgets.dart';

import '../core/addon.dart';
import '../core/mode.dart';
import '../core/mode_addon.dart';
import '../fields/fields.dart';
import '../widgetbook_theme.dart';

export 'package:device_frame_plus/device_frame_plus.dart';

class DeviceFrameConfig {
  const DeviceFrameConfig({
    required this.device,
    required this.orientation,
    required this.hasFrame,
  });

  final DeviceInfo device;
  final Orientation orientation;
  final bool hasFrame;
}

class DeviceFrameMode extends Mode<DeviceFrameConfig> {
  DeviceFrameMode({
    required DeviceInfo device,
    Orientation orientation = Orientation.portrait,
    bool hasFrame = false,
  }) : super(
         DeviceFrameConfig(
           device: device,
           orientation: orientation,
           hasFrame: hasFrame,
         ),
       );

  DeviceFrameMode.fromConfig(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    if (value.device is NoneDevice) {
      return child;
    }

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: DeviceFrame(
          orientation: value.orientation,
          device: value.device,
          isFrameVisible: value.hasFrame,
          screen: ColoredBox(
            color: WidgetbookTheme.of(context).scaffoldBackgroundColor,
            // A navigator below the device frame is necessary to make the popup
            // routes (e.g. dialogs and bottom sheets) work within the device
            // frame, otherwise they would use the navigator from the app
            // builder, causing these routes to fill the whole workbench and not
            // just the device frame.
            child: Navigator(
              onGenerateRoute:
                  (_) => PageRouteBuilder(
                    pageBuilder:
                        (context, _, __) =>
                            value.hasFrame
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

/// An [Addon] for changing the active device/frame. It's based on
/// the [`device_frame`](https://pub.dev/packages/device_frame) package.
class DeviceFrameAddon extends ModeAddon<DeviceFrameConfig> {
  DeviceFrameAddon(List<DeviceInfo> devices)
    : this.devices = [NoneDevice.instance, ...devices],
      super(
        name: 'Device Frame',
        modeBuilder: DeviceFrameMode.fromConfig,
      );

  final List<DeviceInfo> devices;

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<DeviceInfo>(
        name: 'name',
        values: devices,
        initialValue: devices.first,
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
  DeviceFrameConfig valueFromQueryGroup(Map<String, String> group) {
    return DeviceFrameConfig(
      device: valueOf<DeviceInfo>('name', group)!,
      orientation: valueOf<Orientation>('orientation', group)!,
      hasFrame: valueOf<bool>('frame', group)!,
    );
  }
}

class NoneDevice implements DeviceInfo {
  const NoneDevice._();

  static const NoneDevice instance = NoneDevice._();

  @override
  String get name => 'None';

  @override
  DeviceIdentifier get identifier => throw UnimplementedError();

  @override
  Size get frameSize => throw UnimplementedError();

  @override
  Size get screenSize => throw UnimplementedError();

  @override
  double get pixelRatio => throw UnimplementedError();

  @override
  EdgeInsets? get rotatedSafeAreas => throw UnimplementedError();

  @override
  EdgeInsets get safeAreas => throw UnimplementedError();

  @override
  Path get screenPath => throw UnimplementedError();

  @override
  CustomPainter get framePainter => throw UnimplementedError();

  @override
  DeviceInfo copyWith({
    DeviceIdentifier? identifier,
    String? name,
    EdgeInsets? rotatedSafeAreas,
    EdgeInsets? safeAreas,
    Path? screenPath,
    double? pixelRatio,
    CustomPainter? framePainter,
    Size? frameSize,
    Size? screenSize,
  }) {
    return this;
  }
}
