import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/models/widgetbook_device_frame_data.dart';
import 'package:widgetbook_generator/resolvers/builder_function_resolver.dart';

class DeviceFrameBuilderResolver
    extends BuilderFunctionResolver<WidgetbookDeviceFrameBuilder> {
  DeviceFrameBuilderResolver()
      : super(
          createData: (
            name,
            imports,
            dependencies,
          ) =>
              WidgetbookDeviceFrameData(
            name: name,
            importStatement: imports,
            dependencies: dependencies,
          ),
        );
}
