import 'package:flutter/cupertino.dart';
import 'package:widgetbook/src/rendering/rendering.dart';
import 'package:widgetbook/widgetbook.dart';

class CupertinoWidgetbook extends Widgetbook<CupertinoThemeData> {
  const CupertinoWidgetbook({
    required List<WidgetbookCategory> categories,
    required List<WidgetbookTheme<CupertinoThemeData>> themes,
    required AppInfo appInfo,
    List<Device>? devices,
    List<RenderMode>? renderModes,
    Iterable<Locale>? supportedLocales,
    Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    DeviceFrameBuilderFunction? deviceFrameBuilder,
    LocalizationBuilderFunction? localizationBuilder,
    ThemeBuilderFunction<CupertinoThemeData>? themeBuilder,
    ScaffoldBuilderFunction? scaffoldBuilder,
    UseCaseBuilderFunction? useCaseBuilder,
    Key? key,
  }) : super(
          key: key,
          categories: categories,
          themes: themes,
          appInfo: appInfo,
          devices: devices,
          supportedLocales: supportedLocales,
          localizationsDelegates: localizationsDelegates,
          deviceFrameBuilder: deviceFrameBuilder,
          localizationBuilder: localizationBuilder,
          themeBuilder: themeBuilder,
          scaffoldBuilder: scaffoldBuilder,
          useCaseBuilder: useCaseBuilder,
          renderModes: renderModes,
        );
}
