import 'package:widgetbook/src/addons/common/common.dart';
import 'package:widgetbook/src/fields/fields.dart';

class CustomAddOnSetting extends WidgetbookAddOnModel<CustomAddOnSetting> {
  const CustomAddOnSetting({
    required this.data,
  });

  final String data;

  @override
  Map<String, String> toMap() {
    return {
      'data': data,
    };
  }

  @override
  CustomAddOnSetting fromMap(Map<String, String> map) {
    return CustomAddOnSetting(
      data: map['data'] ?? 'Unknown',
    );
  }
}

class CustomAddOn extends WidgetbookAddOn<CustomAddOnSetting> {
  CustomAddOn({
    required super.initialSetting,
  }) : super(
          name: 'Custom',
        );

  @override
  List<Field> get fields => [];
}
