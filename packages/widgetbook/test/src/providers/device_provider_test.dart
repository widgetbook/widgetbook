import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/device_provider.dart';
import 'package:widgetbook/src/providers/device_state.dart';
import 'package:widgetbook/src/models/device.dart';

import '../../helper.dart';

void main() {
  group(
    '$DeviceProvider',
    () {
      List<Device> availableDevices = [
        Apple.iPhone11,
        Samsung.s10,
      ];

      Device currentDevice = availableDevices.first;

      testWidgets(
        'emits DeviceState(<Device>[...], Samsung.s10) when update is called with a new list <Device>[...]',
        (WidgetTester tester) async {
          List<Device> reversedAvailableDevices = [
            Samsung.s10,
            Apple.iPhone11,
          ];

          DeviceProvider themeProvider =
              await tester.pumpBuilderAndReturnProvider(
            DeviceBuilder(
              availableDevices: availableDevices,
              currentDevice: currentDevice,
              child: Container(),
            ),
          );

          themeProvider = await tester.invokeMethodAndReturnPumpedProvider(() {
            themeProvider.update(reversedAvailableDevices);
          });

          expect(
            themeProvider.state,
            equals(
              DeviceState(
                availableDevices: reversedAvailableDevices,
                currentDevice: Samsung.s10,
              ),
            ),
          );
        },
      );

      testWidgets(
        'emits error message when update is called with <Device>[]',
        (WidgetTester tester) async {
          DeviceProvider themeProvider =
              await tester.pumpBuilderAndReturnProvider(
            DeviceBuilder(
              availableDevices: availableDevices,
              currentDevice: currentDevice,
              child: Container(),
            ),
          );

          expect(
            () => themeProvider.update([]),
            throwsA(
              TypeMatcher<ArgumentError>(),
            ),
          );
        },
      );

      testWidgets(
        'emits DeviceState(<Device>[...], ${Samsung.s10}) when selectDevice is called with ${Samsung.s10}',
        (WidgetTester tester) async {
          DeviceProvider themeProvider =
              await tester.pumpBuilderAndReturnProvider(
            DeviceBuilder(
              availableDevices: availableDevices,
              currentDevice: currentDevice,
              child: Container(),
            ),
          );

          themeProvider = await tester.invokeMethodAndReturnPumpedProvider(() {
            themeProvider.selectDevice(Samsung.s10);
          });

          expect(
            themeProvider.state,
            equals(
              DeviceState(
                availableDevices: availableDevices,
                currentDevice: Samsung.s10,
              ),
            ),
          );
        },
      );

      testWidgets(
        'emits DeviceState(<Device>[...], ${Samsung.s10}) when nextDevice is called',
        (WidgetTester tester) async {
          DeviceProvider themeProvider =
              await tester.pumpBuilderAndReturnProvider(
            DeviceBuilder(
              availableDevices: availableDevices,
              currentDevice: currentDevice,
              child: Container(),
            ),
          );

          themeProvider = await tester.invokeMethodAndReturnPumpedProvider(() {
            themeProvider.nextDevice();
          });

          expect(
            themeProvider.state,
            equals(
              DeviceState(
                availableDevices: availableDevices,
                currentDevice: Samsung.s10,
              ),
            ),
          );
        },
      );

      // This tests if the 'cycling' of devices starts at the beginning if the
      // end of the array is reached
      testWidgets(
        'emits DeviceState(<Device>[...], ${Apple.iPhone11}) when nextDevice is called',
        (WidgetTester tester) async {
          DeviceProvider themeProvider =
              await tester.pumpBuilderAndReturnProvider(
            DeviceBuilder(
              availableDevices: availableDevices,
              currentDevice: Samsung.s10,
              child: Container(),
            ),
          );

          themeProvider = await tester.invokeMethodAndReturnPumpedProvider(() {
            themeProvider.nextDevice();
          });

          expect(
            themeProvider.state,
            equals(
              DeviceState(
                availableDevices: availableDevices,
                currentDevice: Apple.iPhone11,
              ),
            ),
          );
        },
      );

      testWidgets(
        'emits DeviceState(<Device>[...], ${Apple.iPhone11}) when previousDevice is called',
        (WidgetTester tester) async {
          DeviceProvider themeProvider =
              await tester.pumpBuilderAndReturnProvider(
            DeviceBuilder(
              availableDevices: availableDevices,
              currentDevice: Samsung.s10,
              child: Container(),
            ),
          );

          themeProvider = await tester.invokeMethodAndReturnPumpedProvider(() {
            themeProvider.previousDevice();
          });

          expect(
            themeProvider.state,
            equals(
              DeviceState(
                availableDevices: availableDevices,
                currentDevice: Apple.iPhone11,
              ),
            ),
          );
        },
      );

      // This tests if the 'cycling' of devices starts at the end if the
      // beginning of the array is reached
      testWidgets(
        'emits DeviceState(<Device>[...], ${Apple.iPhone11}) when previousDevice is called',
        (WidgetTester tester) async {
          DeviceProvider themeProvider =
              await tester.pumpBuilderAndReturnProvider(
            DeviceBuilder(
              availableDevices: availableDevices,
              currentDevice: currentDevice,
              child: Container(),
            ),
          );

          themeProvider = await tester.invokeMethodAndReturnPumpedProvider(() {
            themeProvider.previousDevice();
          });

          expect(
            themeProvider.state,
            equals(
              DeviceState(
                availableDevices: availableDevices,
                currentDevice: Samsung.s10,
              ),
            ),
          );
        },
      );

      testWidgets(
        '.of returns $DeviceProvider instance',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            DeviceBuilder(
              availableDevices: availableDevices,
              currentDevice: currentDevice,
              child: Container(),
            ),
          );

          final BuildContext context = tester.element(find.byType(Container));
          var themeProvider = DeviceProvider.of(context);
          expect(
            themeProvider,
            isNot(null),
          );
        },
      );
    },
  );
}
