import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

abstract class ThemeAddon<T> extends WidgetbookAddOn {
  ThemeAddon({
    required ThemeSetting<T> setting,
  }) : super(
          name: 'themes',
          wrapperBuilder: (context, routerData, child) => _wrapperBuilder<T>(
            context,
            child,
            routerData,
            setting,
          ),
          builder: (context) => _builder<T>(context),
          providerBuilder: (
            context,
          ) =>
              _providerBuilder<T>(context),
          getQueryParameter: (context) => _getQueryParameter<T>(context),
        );
}

Map<String, String> _getQueryParameter<T>(BuildContext context) {
  final selectedItem =
      context.read<ThemeSettingProvider<T>>().value.activeTheme;

  return {
    'theme': selectedItem.name,
  };
}

Widget _builder<T>(BuildContext context) {
  final data = context.watch<ThemeSettingProvider<T>>().value;
  final themes = data.themes;
  final activeTheme = data.activeTheme;

  return Setting(
    name: 'Theme',
    child: DropdownSetting<WidgetbookTheme<T>>(
      options: themes,
      initialSelection: activeTheme,
      optionValueBuilder: (theme) => theme.name,
      onSelected: (item) {
        context.read<ThemeSettingProvider<T>>().tapped(item);
        context.read<AddOnProvider>().update();
        context.goTo(queryParams: _getQueryParameter<T>(context));
      },
    ),
  );
}

Widget _wrapperBuilder<T>(
  BuildContext context,
  Widget child,
  Map<String, dynamic> routerData,
  ThemeSetting<T> data,
) {
  final WidgetbookTheme<T>? selectedTheme = parseRouterData(
    name: 'theme',
    routerData: routerData,
    mappedData: {for (var e in data.themes) e.name: e},
  );

  final initialData =
      selectedTheme != null ? data.copyWith(activeTheme: selectedTheme) : data;

  return ChangeNotifierProvider(
    key: ValueKey(initialData),
    create: (_) => ThemeSettingProvider<T>(
      initialData,
    ),
    child: child,
  );
}

SingleChildWidget _providerBuilder<T>(
  BuildContext context,
) {
  final selection = context.watch<ThemeSettingProvider<T>>().value;
  final theme = selection.activeTheme;

  return ChangeNotifierProvider(
    key: ValueKey(theme),
    create: (_) => ThemeProvider(theme),
  );
}
