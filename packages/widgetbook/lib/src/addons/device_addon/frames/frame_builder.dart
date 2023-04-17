import 'package:flutter/widgets.dart';

import '../device_setting.dart';

abstract class FrameBuilder {
  FrameBuilder({
    required this.setting,
  });

  final DeviceSetting setting;

  Widget build(BuildContext context, Widget child);
}
