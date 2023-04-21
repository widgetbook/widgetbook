import 'package:flutter/widgets.dart';

import 'frame_builder.dart';

class FramelessBuilder extends FrameBuilder {
  FramelessBuilder({
    required super.setting,
  });

  @override
  Widget build(BuildContext context, Widget child) {
    return child;
  }
}
