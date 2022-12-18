import 'package:widgetbook/widgetbook.dart';

const customTestDevice = Device.special(
  name: 'Test',
  resolution: Resolution(
    nativeSize: DeviceSize(width: 400, height: 400),
    scaleFactor: 1,
  ),
);
final devices = [
  Apple.iPhone13Mini,
  Apple.iPhone12,
  customTestDevice,
];

final noFrame = NoFrame();

final deviceFrame = DefaultDeviceFrame(
  setting: DeviceSetting.firstAsSelected(devices: devices),
);

final widgetbookFrame = WidgetbookFrame(
  setting: DeviceSetting.firstAsSelected(devices: devices),
);

final frames = [
  deviceFrame,
  noFrame,
  widgetbookFrame,
];

final frameSetting = FrameSetting.firstAsSelected(
  frames: frames,
);

final deviceSetting = DeviceSetting.firstAsSelected(
  devices: devices,
);
