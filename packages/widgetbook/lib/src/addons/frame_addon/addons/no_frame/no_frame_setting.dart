import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/widgetbook.dart';

part 'no_frame_setting.freezed.dart';

@freezed
class NoFrameSetting extends WidgetbookAddOnModel with _$NoFrameSetting {
  factory NoFrameSetting() = _NoFrameSetting;

  const NoFrameSetting._();
}
