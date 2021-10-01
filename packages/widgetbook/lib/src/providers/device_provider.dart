import 'package:flutter/material.dart';
import 'package:widgetbook/src/models/device.dart';
import 'package:widgetbook/src/providers/device_state.dart';
import 'package:widgetbook/src/providers/provider.dart';

class DeviceBuilder extends StatefulWidget {
  final Widget child;
  final List<Device> availableDevices;
  final Device currentDevice;

  const DeviceBuilder({
    Key? key,
    required this.child,
    required this.availableDevices,
    required this.currentDevice,
  }) : super(key: key);

  @override
  _DeviceBuilderState createState() => _DeviceBuilderState();
}

class _DeviceBuilderState extends State<DeviceBuilder> {
  late DeviceState state;

  @override
  initState() {
    state = DeviceState(
      availableDevices: widget.availableDevices,
      currentDevice: widget.currentDevice,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DeviceProvider(
      state: state,
      onStateChanged: (DeviceState state) {
        setState(() {
          this.state = state;
        });
      },
      child: widget.child,
    );
  }
}

class DeviceProvider extends Provider<DeviceState> {
  const DeviceProvider({
    required DeviceState state,
    required ValueChanged<DeviceState> onStateChanged,
    required Widget child,
    Key? key,
  }) : super(
          state: state,
          onStateChanged: onStateChanged,
          child: child,
          key: key,
        );

  static DeviceProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DeviceProvider>();
  }

  void update(List<Device> devices) {
    if (devices.isEmpty) {
      throw ArgumentError.value(
        devices,
        'update',
        'Cannot be empty',
      );
    }

    emit(
      DeviceState(
        availableDevices: devices,
        currentDevice: devices.first,
      ),
    );
  }

  void selectDevice(Device device) {
    emit(
      DeviceState(
        availableDevices: state.availableDevices,
        currentDevice: device,
      ),
    );
  }

  void nextDevice() {
    int index = state.availableDevices.indexOf(state.currentDevice);
    int nextIndex = (index + 1) % state.availableDevices.length;
    Device nextDevice = state.availableDevices[nextIndex];
    emit(
      DeviceState(
        availableDevices: state.availableDevices,
        currentDevice: nextDevice,
      ),
    );
  }

  void previousDevice() {
    int index = state.availableDevices.indexOf(state.currentDevice);
    int previousIndex =
        index == 0 ? state.availableDevices.length - 1 : index - 1;
    Device previousDevice = state.availableDevices[previousIndex];
    emit(
      DeviceState(
        availableDevices: state.availableDevices,
        currentDevice: previousDevice,
      ),
    );
  }
}
