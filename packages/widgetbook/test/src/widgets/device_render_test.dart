import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/device_provider.dart';
import 'package:widgetbook/src/providers/device_state.dart';
import 'package:widgetbook/src/providers/injected_theme_provider.dart';
import 'package:widgetbook/src/providers/injected_theme_state.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';
import 'package:widgetbook/src/widgets/device_render.dart';
import 'package:widgetbook/widgetbook.dart';

const lightColor = Colors.green;
const darkColor = Colors.yellow;
const key = ValueKey('colored-container');
const key2 = ValueKey('sized-container');

class ThemedWidget extends StatelessWidget {
  const ThemedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      key: key,
      color: brightness == Brightness.light ? lightColor : darkColor,
    );
  }
}

class DeviceWidthWidget extends StatelessWidget {
  const DeviceWidthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      key: key2,
      width: width,
    );
  }
}

/// Sets size of window to render a [Device],
/// otherwise test fails
void _setSize(WidgetTester tester) {
  tester.binding.window.physicalSizeTestValue = const Size(
    3000,
    3000,
  );
}

Widget getMaterialApp(Brightness brightness) {
  const storyName = 'Not important';

  return MaterialApp(
    theme: ThemeData(brightness: brightness),
    home: ThemeProvider(
      state: brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark,
      onStateChanged: (_) {},
      child: DeviceProvider(
        state: DeviceState(
          availableDevices: [Apple.iPhone11],
          currentDevice: Apple.iPhone11,
        ),
        onStateChanged: (_) {},
        child: InjectedThemeProvider(
          state: InjectedThemeState(
            lightTheme: ThemeData(),
            darkTheme: ThemeData(),
          ),
          onStateChanged: (_) {},
          child: DeviceRender(
            story: WidgetbookUseCase(
              name: storyName,
              builder: (context) => const ThemedWidget(),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget getMaterialAppWithDevice(Device device) {
  const storyName = 'Not important';

  return MaterialApp(
    theme: ThemeData(brightness: Brightness.light),
    home: ThemeProvider(
      state: ThemeMode.light,
      onStateChanged: (_) {},
      child: DeviceProvider(
        state: DeviceState(
          availableDevices: [device],
          currentDevice: device,
        ),
        onStateChanged: (_) {},
        child: InjectedThemeProvider(
          state: InjectedThemeState(
            lightTheme: ThemeData(),
            darkTheme: ThemeData(),
          ),
          onStateChanged: (_) {},
          child: DeviceRender(
            story: WidgetbookUseCase(
              name: storyName,
              builder: (context) => const DeviceWidthWidget(),
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> expectColorForSetBrightness({
  required WidgetTester tester,
  required Brightness brightness,
  required Color expectedColor,
}) async {
  _setSize(tester);
  await tester.pumpWidget(getMaterialApp(brightness));

  final themedWidgetFinder = find.byKey(key);
  expect(
    themedWidgetFinder,
    findsOneWidget,
  );

  final container = tester.firstWidget(themedWidgetFinder) as Container;

  expect(
    container.color,
    equals(expectedColor),
  );
}

Future<void> expectWidthForDevice({
  required WidgetTester tester,
  required Device device,
  required double expectedWidth,
}) async {
  _setSize(tester);
  await tester.pumpWidget(getMaterialAppWithDevice(device));

  final containerWidgetFinder = find.byKey(key2);

  expect(
    containerWidgetFinder,
    findsOneWidget,
  );

  final container = tester.firstWidget(containerWidgetFinder) as Container;

  expect(
    container.constraints!.maxWidth,
    equals(expectedWidth),
  );
}

void main() {
  group(
    '$DeviceRender',
    () {
      testWidgets(
        'renders $WidgetbookUseCase with lightColor when brightness is set to ${Brightness.light}',
        (tester) async {
          await expectColorForSetBrightness(
            tester: tester,
            brightness: Brightness.light,
            expectedColor: lightColor,
          );
        },
      );

      testWidgets(
        'renders $WidgetbookUseCase with darkColor when brightness is set to ${Brightness.dark}',
        (tester) async {
          await expectColorForSetBrightness(
            tester: tester,
            brightness: Brightness.dark,
            expectedColor: darkColor,
          );
        },
      );

      testWidgets(
        'renders $WidgetbookUseCase with iPhone 12 width ${Apple.iPhone12.resolution.logicalSize.width}',
        (tester) async {
          await expectWidthForDevice(
            tester: tester,
            device: Apple.iPhone12,
            expectedWidth: Apple.iPhone12.resolution.logicalSize.width,
          );
        },
      );

      testWidgets(
        'renders $WidgetbookUseCase with Samsung S21 Ultra width ${Samsung.s21ultra.resolution.logicalSize.width}',
        (tester) async {
          await expectWidthForDevice(
            tester: tester,
            device: Samsung.s21ultra,
            expectedWidth: Samsung.s21ultra.resolution.logicalSize.width,
          );
        },
      );
    },
  );
}
