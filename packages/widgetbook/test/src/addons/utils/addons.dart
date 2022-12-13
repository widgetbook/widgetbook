import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

final devices = [
  Apple.iPhone11,
  Apple.iPhone12,
  const Device.special(
    name: 'Test',
    resolution: Resolution(
      nativeSize: DeviceSize(width: 400, height: 400),
      scaleFactor: 1,
    ),
  ),
];

final deviceFrameFrame = DefaultDeviceFrame(
  setting: DeviceSetting.firstAsSelected(devices: devices),
);

const coloredBoxKey = Key('coloredBox');

const textKey = Key('textKey');

final rendererKey = GlobalKey();
