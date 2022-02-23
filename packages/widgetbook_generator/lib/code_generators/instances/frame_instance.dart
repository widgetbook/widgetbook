import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/code_generators/instances/boolean_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/string_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class FrameInstance extends Instance {
  FrameInstance({
    required WidgetbookFrame frame,
  }) : super(
          name: '$WidgetbookFrame',
          properties: [
            Property(
              key: 'name',
              instance: StringInstance.value(frame.name),
            ),
            Property(
              key: 'allowsDevices',
              instance: BooleanInstance.value(
                frame.allowsDevices,
              ),
            ),
          ],
        );
}
