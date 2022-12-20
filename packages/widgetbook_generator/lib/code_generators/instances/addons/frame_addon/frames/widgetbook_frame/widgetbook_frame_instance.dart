import 'package:widgetbook_generator/code_generators/instances/addons/frame_addon/frames/frames.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

class WidgetbookFrameInstance extends Instance {
  WidgetbookFrameInstance({
    required List<Device> devices,
  }) : super(
          name: 'WidgetbookFrame',
          properties: [
            Property(
              key: 'setting',
              instance: WidgetbookFrameSettingInstance(
                devices: devices,
              ),
            ),
          ],
        );
}
