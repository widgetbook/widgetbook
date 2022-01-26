import 'package:riverpod/riverpod.dart';
import 'package:widgetbook/src/devices/devices_state.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

final devicesProvider =
    StateNotifierProvider<DevicesNotifier, DevicesState>((ref) {
  return DevicesNotifier();
});

class DevicesNotifier extends StateNotifier<DevicesState> {
  DevicesNotifier()
      : super(
          DevicesState(
            devices: [],
          ),
        );

  void hotReloadUpdate({
    required List<Device> devices,
  }) {
    state = state.copyWith(devices: devices);
  }
}
