import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/src/addons/widgets/addon_option_list.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/widgetbook.dart';

abstract class ThemeAddon<T> extends WidgetbookAddOn {
  ThemeAddon({
    required ThemeSetting<T> setting,
  }) : super(
          icon: const Icon(Icons.theater_comedy),
          name: 'themes',
          wrapperBuilder: (context, routerData, child) => _wrapperBuilder<T>(
            context,
            child,
            setting,
          ),
          builder: (context) => _builder<T>(context),
          providerBuilder: (context, index) =>
              _providerBuilder<T>(context, index),
          selectionCount: (context) => _selectionCount<T>(context),
          getQueryParameter: (context) => _getQueryParameter<T>(context),
        );
}

String _getQueryParameter<T>(BuildContext context) {
  final selectedItems =
      context.read<ThemeSettingProvider<T>>().value.activeThemes;

  return selectedItems.map((e) => e).join(',');
}

int _selectionCount<T>(BuildContext context) {
  return context.read<ThemeSettingProvider<T>>().value.activeThemes.length;
}

Widget _builder<T>(BuildContext context) {
  final data = context.watch<ThemeSettingProvider<T>>().value;
  final themes = data.themes;
  final activeThemes = data.activeThemes;

  return AddonOptionList<WidgetbookTheme<T>>(
    name: 'Themes',
    options: themes,
    selectedOptions: activeThemes,
    builder: (item) => Text(item.name),
    onTap: (item) {
      context.read<ThemeSettingProvider<T>>().tapped(item);
      context.read<AddOnProvider>().update();
      navigate(context);
    },
  );
}

Widget _wrapperBuilder<T>(
  BuildContext context,
  Widget child,
  ThemeSetting<T> data,
) {
  return ChangeNotifierProvider(
    key: const ValueKey('agdliuahsdflkjhasdflkjhasdglkjh'),
    create: (_) => ThemeSettingProvider<T>(
      data,
    ),
    child: child,
  );
}

SingleChildWidget _providerBuilder<T>(
  BuildContext context,
  int index,
) {
  final selection = context.watch<ThemeSettingProvider<T>>().value;
  final theme = selection.activeThemes.isEmpty
      ? selection.themes.first
      : selection.activeThemes.elementAt(index);
  return ChangeNotifierProvider(
    create: (_) => ThemeProvider(theme),
  );
}
