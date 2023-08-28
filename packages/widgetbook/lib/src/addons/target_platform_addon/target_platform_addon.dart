import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../../../widgetbook.dart';

/// A [WidgetbookAddon] for changing the active [TargetPlatform].
class TargetPlatformAddon extends WidgetbookAddon<TargetPlatform> {
  TargetPlatformAddon({
    required this.targetPlatforms,
    TargetPlatform? initialSetting,
  })  : assert(
          targetPlatforms.isNotEmpty,
          'targetPlatforms cannot be empty',
        ),
        super(
          name: 'Target platform',
          initialSetting: initialSetting ?? targetPlatforms.first,
        );

  final List<TargetPlatform> targetPlatforms;

  @override
  List<Field> get fields {
    return [
      ListField<TargetPlatform>(
        name: 'name',
        group: 'Target platform',
        values: targetPlatforms,
        initialValue: initialSetting,
        labelBuilder: (targetPlatform) => targetPlatform.name,
      ),
    ];
  }

  @override
  TargetPlatform settingFromQueryGroup(Map<String, String> group) {
    return targetPlatforms.firstWhere(
      (targetPlatform) => targetPlatform.name == group['name'],
      orElse: () => initialSetting,
    );
  }

  PlatformStyle getPlatformStyle() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return PlatformStyle.Material;
      case TargetPlatform.iOS:
        return PlatformStyle.Cupertino;
      case TargetPlatform.fuchsia:
        return PlatformStyle.Material;
      case TargetPlatform.linux:
        return PlatformStyle.Material;
      case TargetPlatform.macOS:
        return PlatformStyle.Cupertino;
      case TargetPlatform.windows:
        return PlatformStyle.Material;
    }
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    TargetPlatform setting,
  ) {
    debugDefaultTargetPlatformOverride = setting;
    return PlatformProvider(
      settings: PlatformSettingsData(
        platformStyle: PlatformStyleData(web: getPlatformStyle()),
      ),
      builder: (BuildContext context) => Material(child: child),
    );
  }
}
