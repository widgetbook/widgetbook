import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/frame_addon/addons/device_addon/device_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/addons/device_addon/device_setting_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../utils/addon_test_helper.dart';
import '../../utils/addons.dart';
import '../../utils/extensions/widget_tester_extension.dart';
import '../../utils/theme_wrapper.dart';
import '../frame_utilities.dart';

Widget frameAddonWrapper({
  required Widget child,
  required List<Frame> frames,
}) {
  return addOnProviderWrapper<List<Devices>>(
    child: child,
    addons: [
      FrameAddon(
        setting: FrameSetting.firstAsSelected(
          frames: frames,
        ),
      )
    ],
  );
}

void main() {
  late Renderer renderer;

  setUp(() {
    renderer = Renderer(
      key: rendererKey,
      appBuilder: (context, child) {
        final frameBuilder = context.frameBuilder;

        return frameBuilder!(context, child);
      },
      useCaseBuilder: (context) => const Text(
        'Some Frame',
        key: textKey,
      ),
    );
  });

  group('$DeviceAddon', () {
    testWidgets(
      'launches with an active device',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => frameAddonWrapper(
            frames: frames,
            child: child,
          ),
          child: renderer,
          expect: () {
            final context =
                tester.findContextByKey(const Key('app_builder_key'));

            final device = context.read<DeviceProvider>();
            expect(device.value, deviceSetting);

            expectDevice(deviceName: device.value.activeDevice.name);
          },
        );
      },
    );

    testWidgets(
      'can activate a device',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => frameAddonWrapper(
            frames: frames,
            child: child,
          ),
          child: renderer,
          act: (context) async =>
              context.read<DeviceSettingProvider>().deviceTapped(
                    Apple.iPhone12,
                  ),
          expect: () => expectDevice(
            deviceName: Apple.iPhone12.name,
          ),
        );
      },
    );

    testWidgets(
      'activates devices in order',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          child: renderer,
          build: (child) => frameAddonWrapper(
            frames: frames,
            child: child,
          ),
          act: (context) async {
            context.read<DeviceSettingProvider>()
              ..deviceTapped(
                Apple.iPhone12,
              )
              ..deviceTapped(Apple.iPhone13Mini)
              ..deviceTapped(customTestDevice);
          },
          // Should expect Custom , since any custom device is not mapped to DeviceToDeviceInfo
          expect: () => expectDevice(deviceName: 'custom'),
        );
      },
    );

    testWidgets(
      'can switch devices orientation',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          child: renderer,
          build: (child) => frameAddonWrapper(
            frames: frames,
            child: child,
          ),
          act: (context) async {
            context
                .read<DeviceSettingProvider>()
                .orientationTapped(Orientation.landscape);
          },
          expect: () {
            final context =
                tester.findContextByKey(const Key('app_builder_key'));

            final frame = context.read<DeviceProvider>();
            expect(frame.value.orientation, Orientation.landscape);
          },
        );
      },
    );
  });
}
