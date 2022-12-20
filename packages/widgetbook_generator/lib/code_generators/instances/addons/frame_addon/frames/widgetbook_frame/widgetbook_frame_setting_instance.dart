import 'package:widgetbook_generator/code_generators/instances/addons/frame_addon/frames/frames.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

/// Currently these two Frames share the same implementation
class WidgetbookFrameSettingInstance extends DeviceFrameSettingInstance {
  WidgetbookFrameSettingInstance({required List<Device> devices})
      : super(devices: devices);
}
