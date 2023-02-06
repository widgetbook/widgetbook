import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/addons/device_addon/device_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/addons/device_addon/device_setting_provider.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

export './device_setting.dart';

class DeviceAddon extends WidgetbookAddOn {
  DeviceAddon({
    required DeviceSetting setting,
  }) : super(
          name: 'Device',
          wrapperBuilder: (context, routerData, child) => _wrapperBuilder(
            context,
            child,
            routerData,
            setting,
          ),
          builder: _builder,
          providerBuilder: _providerBuilder,
          getQueryParameter: _getQueryParameter,
        );
}

SingleChildWidget _providerBuilder(
  BuildContext context,
) {
  final provider = context.watch<DeviceSettingProvider?>();
  if (provider == null) {}
  final setting = context.watch<DeviceSettingProvider>().value;

  return ChangeNotifierProvider(
    key: ValueKey(setting),
    create: (context) => DeviceProvider(
      setting,
    ),
  );
}

Widget _wrapperBuilder(
  BuildContext context,
  Widget child,
  Map<String, dynamic> routerData,
  DeviceSetting data,
) {
  final Device? selectedDevice = parseRouterData(
    name: 'device',
    routerData: routerData,
    mappedData: {for (var e in data.devices) e.name: e},
  );
  final Orientation? selectedOrientation = parseRouterData(
    name: 'orientation',
    routerData: routerData,
    mappedData: {
      Orientation.portrait.name: Orientation.portrait,
      Orientation.landscape.name: Orientation.landscape,
    },
  );

  final initialData = selectedDevice != null
      ? data.copyWith(
          activeDevice: selectedDevice,
          orientation: selectedOrientation ?? Orientation.portrait,
        )
      : data;
  return ChangeNotifierProvider(
    key: ValueKey(initialData),
    create: (_) => DeviceSettingProvider(initialData),
    child: child,
  );
}

Map<String, String> _getQueryParameter(BuildContext context) {
  final selectedItem = context.read<DeviceSettingProvider>().value;

  final activeDevice = selectedItem.activeDevice;
  final orientation = selectedItem.orientation;

  return {
    'orientation': orientation.name,
    'device': activeDevice.name,
  };
}

Widget _builder(BuildContext context) {
  final setting = context.watch<DeviceSettingProvider>().value;
  final devices = setting.devices;
  final activeDevice = setting.activeDevice;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      SubSetting(
        name: 'Device',
        child: DropdownSetting<Device>(
          options: devices,
          optionValueBuilder: (device) => device.name,
          initialSelection: activeDevice,
          onSelected: (device) {
            context.read<DeviceSettingProvider>().deviceTapped(device);
            context.read<AddOnProvider>().update();
            context.goTo(queryParams: _getQueryParameter(context));
          },
        ),
      ),
      SubSetting(
        name: 'Orientation',
        child: DropdownSetting<Orientation>(
          options: const [
            Orientation.portrait,
            Orientation.landscape,
          ],
          optionValueBuilder: (orientation) => orientation.name,
          initialSelection: setting.orientation,
          onSelected: (orientation) {
            context.read<DeviceSettingProvider>().orientationTapped(
                  orientation,
                );
            context.read<AddOnProvider>().update();
            context.goTo(queryParams: _getQueryParameter(context));
          },
        ),
      ),
    ],
  );
}

extension DeviceExtension on BuildContext {
  Device get device => watch<DeviceProvider>().value.activeDevice;
}

extension OrientationExtension on BuildContext {
  Orientation get orientation => watch<DeviceProvider>().value.orientation;
}
