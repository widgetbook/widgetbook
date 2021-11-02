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
    },
  );
}
