import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/frame_addon/frame_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/frame_selection_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';
import '../utils/addons.dart';
import '../utils/extensions/widget_tester_extension.dart';
import '../utils/theme_wrapper.dart';
import 'frame_utilities.dart';

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

  group('$FrameAddon', () {
    testWidgets(
      'launches with an active frame',
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

            final frame = context.read<FrameProvider>();
            expect(frame.value.name, 'Device Frame');
          },
        );
      },
    );

    testWidgets(
      'can activate a frame',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => frameAddonWrapper(
            frames: frames,
            child: child,
          ),
          child: renderer,
          act: (context) async {
            context.read<FrameSettingProvider>().tapped(
                  widgetbookFrame,
                );
          },
          expect: () {
            final context =
                tester.findContextByKey(const Key('app_builder_key'));

            final frame = context.read<FrameProvider>();
            expect(frame.value.name, 'Widgetbook Frame');
            expectWidgetbookFrame(
              expectedFrameName: 'Widgetbook Frame',
              tester: tester,
              context: context,
            );
          },
        );
      },
    );

    testWidgets(
      'activates frames in order',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          child: renderer,
          build: (child) => frameAddonWrapper(
            frames: frames,
            child: child,
          ),
          act: (context) async {
            context.read<FrameSettingProvider>()
              ..tapped(
                widgetbookFrame,
              )
              ..tapped(deviceFrame)
              ..tapped(noFrame);
          },
          expect: () {
            final context =
                tester.findContextByKey(const Key('app_builder_key'));

            final frame = context.read<FrameProvider>();
            expect(frame.value.name, 'No Frame');
            expectNoFrame(
              context: context,
              tester: tester,
              expectedFrameName: 'No Frame',
            );
          },
        );
      },
    );
  });
}
