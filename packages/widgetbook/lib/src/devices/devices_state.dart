import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_models/widgetbook_models.dart';

part 'devices_state.freezed.dart';

@freezed
class DevicesState with _$DevicesState {
  factory DevicesState({
    required List<Device> devices,
  }) = _DevicesState;
}
