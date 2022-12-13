import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/frames/device_frame/device_provider.dart';
import 'package:widgetbook/src/addons/frame_addon/frames/device_frame/device_setting_provider.dart';
import 'package:widgetbook/src/addons/utilities/utilities.dart';
import 'package:widgetbook/src/addons/widgets/widgets.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/widgetbook.dart';

class DeviceFrameAddon extends WidgetbookAddOn {
  DeviceFrameAddon({
    required DeviceSetting setting,
  }) : super(
          icon: const Icon(Icons.phone),
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
  final setting = context.watch<DeviceSettingProvider>().value;

  return ChangeNotifierProvider(
    key: ValueKey(setting),
    create: (context) => DeviceProvider(
      setting!,
    ),
  );
}

Widget _wrapperBuilder(
  BuildContext context,
  Widget child,
  Map<String, dynamic> routerData,
  DeviceSetting data,
) {
  final activeDeviceData = routerData['Frame'] as String?;

  final activeDevice = activeDeviceData != null
      ? context.jsonToString(
          data: activeDeviceData,
          addonItem: 'device',
        )
      : null;

  final activeOrientation = activeDeviceData != null
      ? context.jsonToString(
          data: activeDeviceData,
          addonItem: 'orientation',
        )
      : null;

  Device? selectedDevice;

  if (activeDevice != null) {
    final mapFrames = {for (var e in data.devices) e.name: e};
    selectedDevice = mapFrames[activeDevice];
  }
  Orientation? selectedOrientation;
  if (activeOrientation != null) {
    if (activeOrientation == 'portrait') {
      selectedOrientation = Orientation.portrait;
    } else {
      selectedOrientation = Orientation.landscape;
    }
  }

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

Map<String, dynamic> _getQueryParameter(BuildContext context) {
  final selectedItem = context.read<DeviceSettingProvider>().value;

  final activeDevice = selectedItem?.activeDevice;
  final orientation = selectedItem?.orientation.name;

  return <String, dynamic>{
    'orientation': orientation,
    'device': activeDevice?.name,
  };
}

Widget _builder(BuildContext context) {
  final setting = context.watch<DeviceSettingProvider>().value;
  final devices = setting?.devices;
  final activeDevice = setting?.activeDevice;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: AddonOptionList<Device>(
          name: 'Devices',
          options: devices!,
          selectedOption: activeDevice!,
          builder: (item) => Text(item.name),
          onTap: (item) {
            context.read<DeviceSettingProvider>().deviceTapped(item);
            context.read<AddOnProvider>().update();
            navigate(context);
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ToggleButtons(
          borderColor: Colors.black,
          fillColor: Colors.grey,
          borderWidth: 1,
          selectedColor: Colors.white,
          borderRadius: BorderRadius.circular(5),
          onPressed: (int index) {
            context.read<DeviceSettingProvider>().orientationTapped(
                  index == 0 ? Orientation.portrait : Orientation.landscape,
                );
            context.read<AddOnProvider>().update();
            navigate(context);
          },
          isSelected: [
            setting!.orientation == Orientation.portrait,
            setting.orientation == Orientation.landscape,
          ],
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Portrait',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Landscape',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
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
