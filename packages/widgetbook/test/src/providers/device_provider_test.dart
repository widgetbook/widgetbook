import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/models/device.dart';
import 'package:widgetbook/src/providers/device_provider.dart';
import 'package:widgetbook/src/providers/device_state.dart';

import '../../helper/provider_helper.dart';
import '../../helper/widget_test_helper.dart';

extension _WidgetTesterProviderExtension on WidgetTester {
  Future<DeviceProvider> pumpProvider({
    required List<Device> availableDevices,
    required Device currentDevice,
  }) async {
    final themeProvider = await pumpBuilderAndReturnProvider<DeviceProvider>(
      DeviceBuilder(
        availableDevices: availableDevices,
        currentDevice: currentDevice,
        child: Container(),
      ),
    );
    return themeProvider;
  }
}

void main() {
  group(
    '$DeviceProvider',
    () {
      final availableDevices = [
        Apple.iPhone11,
        Samsung.s10,
      ];

      final currentDevice = availableDevices.first;

      testWidgets(
        'emits DeviceState(<Device>[...], Samsung.s10) when update is called with a new list <Device>[...]',
        (WidgetTester tester) async {
          final reversedAvailableDevices = [
            Samsung.s10,
            Apple.iPhone11,
          ];

          var provider = await tester.pumpProvider(
            availableDevices: availableDevices,
            currentDevice: currentDevice,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(() {
            provider.update(reversedAvailableDevices);
          });

          expect(
            provider.state,
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
          final provider = await tester.pumpProvider(
            availableDevices: availableDevices,
            currentDevice: currentDevice,
          );

          expect(
            () => provider.update([]),
            throwsA(
              const TypeMatcher<ArgumentError>(),
            ),
          );
        },
      );

      testWidgets(
        'emits DeviceState(<Device>[...], ${Samsung.s10}) when selectDevice is called with ${Samsung.s10}',
        (WidgetTester tester) async {
          var provider = await tester.pumpProvider(
            availableDevices: availableDevices,
            currentDevice: currentDevice,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(() {
            provider.selectDevice(Samsung.s10);
          });

          expect(
            provider.state,
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
          var provider = await tester.pumpProvider(
            availableDevices: availableDevices,
            currentDevice: currentDevice,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(() {
            provider.nextDevice();
          });

          expect(
            provider.state,
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
          var provider = await tester.pumpProvider(
            availableDevices: availableDevices,
            currentDevice: Samsung.s10,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(() {
            provider.nextDevice();
          });

          expect(
            provider.state,
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
          var provider = await tester.pumpProvider(
            availableDevices: availableDevices,
            currentDevice: Samsung.s10,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(() {
            provider.previousDevice();
          });

          expect(
            provider.state,
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
          var provider = await tester.pumpProvider(
            availableDevices: availableDevices,
            currentDevice: currentDevice,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(() {
            provider.previousDevice();
          });

          expect(
            provider.state,
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
          final provider = DeviceProvider.of(context);
          expect(
            provider,
            isNot(null),
          );
        },
      );
    },
  );
}
