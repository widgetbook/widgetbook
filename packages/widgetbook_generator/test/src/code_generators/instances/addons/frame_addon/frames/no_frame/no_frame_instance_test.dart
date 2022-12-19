import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/addons/frame_addon/frames/no_frame/no_frame_instance.dart';

void main() {
  group(
    '$NoFrameInstance',
    () {
      test('.name is "NoFrame"', () {
        const sut = NoFrameInstance();
        expect(sut.name, equals('NoFrame'));
      });
    },
  );
}
