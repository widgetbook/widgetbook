import 'package:widgetbook_models/widgetbook_models.dart';

Device iPhone = Apple.iPhone12;
Device s10 = Samsung.s10;
Device customDevice = const Device.special(
  name: 'Squared device',
  resolution: Resolution(
    nativeSize: DeviceSize(
      height: 200,
      width: 200,
    ),
    scaleFactor: 2,
  ),
);
