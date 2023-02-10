import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/addons/addons.dart';

part 'frame_setting.freezed.dart';

@freezed
class FrameSetting extends WidgetbookAddOnModel with _$FrameSetting {
  @Assert('frames.isNotEmpty', 'frames cannot be empty')
  factory FrameSetting({
    required List<Frame> frames,
    required Frame activeFrame,
  }) = _FrameSetting;

  /// Sets the first theme within `themes` as the active theme on
  /// startup
  factory FrameSetting.firstAsSelected({
    required List<Frame> frames,
  }) {
    assert(
      frames.isNotEmpty,
      'Please specify at least one Frame',
    );
    return FrameSetting(
      activeFrame: frames.first,
      frames: frames,
    );
  }

  const FrameSetting._();

  @override
  Map<String, String> toQueryParameter() {
    return {
      'frame': activeFrame.name,
    }..addAll(
        activeFrame.addon.value.toQueryParameter(),
      );
  }
}
