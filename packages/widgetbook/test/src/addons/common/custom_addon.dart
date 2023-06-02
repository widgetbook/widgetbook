import 'package:widgetbook/src/addons/common/common.dart';
import 'package:widgetbook/src/fields/fields.dart';

class CustomAddon extends WidgetbookAddon<String> {
  CustomAddon({
    required super.initialSetting,
  }) : super(
          name: 'Custom',
        );

  @override
  List<Field> get fields => [];

  @override
  String settingFromQueryGroup(Map<String, String> group) => initialSetting;
}
