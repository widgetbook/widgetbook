import 'package:bloc/bloc.dart';
import 'package:widgetbook/models/device.dart';

part 'device_state.dart';

class DeviceCubit extends Cubit<DeviceState> {
  DeviceCubit({
    required List<Device> devices,
  }) : super(
          DeviceState(
            availableDevices: devices,
            currentDevice: devices.first,
          ),
        );

  void update(List<Device> devices) {
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
