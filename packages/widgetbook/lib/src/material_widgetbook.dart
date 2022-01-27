import 'package:flutter/material.dart';
import 'package:widgetbook/src/rendering/rendering.dart';
import 'package:widgetbook/widgetbook.dart';

class MaterialWidgetbook extends Widgetbook<ThemeData> {
  const MaterialWidgetbook({
    required List<WidgetbookCategory> categories,
    required List<WidgetbookTheme<ThemeData>> themes,
    required AppInfo appInfo,
    List<Device>? devices,
    List<RenderMode>? renderModes,
    Iterable<Locale>? supportedLocales,
    Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    DeviceFrameBuilderFunction? deviceFrameBuilder,
    LocalizationBuilderFunction? localizationBuilder,
    ThemeBuilderFunction<ThemeData>? themeBuilder,
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
