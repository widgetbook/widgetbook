import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/writer/device_size_writer.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

void main() {
  group(
    '$DeviceSizeWriter',
    () {
      test(
        'emits code when write is called',
        () {
          final instance = DeviceSizeWriter().write(
            const DeviceSize(
              width: 100,
              height: 100,
            ),
          );

          expect(
            instance,
            equals('''
DeviceSize(
  width: 100.0,
  height: 100.0,
)
'''),
          );
        },
      );
    },
  );
}
