import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/src/addons/widgets/addon_option_list.dart';
import 'package:widgetbook/src/navigation/router.dart';

class ThemeAddon extends WidgetbookAddOn {
  ThemeAddon({
    required List<ThemeData> themes,
  }) : super(
          icon: const Icon(Icons.theater_comedy),
          name: 'themes',
          wrapperBuilder: (context, routerData, child) =>
              _wrapperBuilder(context, child, themes),
          builder: _builder,
          providerBuilder: _providerBuilder,
          selectionCount: _selectionCount,
          getQueryParameter: _getQueryParameter,
        );
}

String _getQueryParameter(BuildContext context) {
  final selectedItems =
      context.read<ThemeSelectionProvider>().value.activeThemes;

  return selectedItems.map((e) => e).join(',');
}

int _selectionCount(BuildContext context) {
  return context.read<ThemeSelectionProvider>().value.activeThemes.length;
}

Widget _builder(BuildContext context) {
  final data = context.watch<ThemeSelectionProvider>().value;
  final themes = data.themes;
  final activeThemes = data.activeThemes;

  return AddonOptionList<ThemeData>(
    name: 'Themes',
    options: themes,
    selectedOptions: activeThemes,
    // TODO adjust this
    builder: (item) => Text(item.toString()),
    onTap: (item) {
      context.read<ThemeSelectionProvider>().tapped(item);
      context.read<AddOnProvider>().update();
      navigate(context);
    },
  );
}

Widget _wrapperBuilder(
  BuildContext context,
  Widget child,
  List<ThemeData> data,
) {
  return ChangeNotifierProvider(
    create: (_) => ThemeSelectionProvider(
      ThemeSelection(
        themes: data,
        activeThemes: {
          data.first,
        },
      ),
    ),
    child: child,
  );
}

SingleChildWidget _providerBuilder(
  BuildContext context,
  int index,
) {
  final selection = context.watch<ThemeSelectionProvider>().value;
  final theme = selection.activeThemes.isEmpty
      ? selection.themes.first
      : selection.activeThemes.elementAt(index);
  return ChangeNotifierProvider(
    create: (_) => ThemeProvider(theme),
  );
}

extension ThemeExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  ThemeData get theme => watch<ThemeProvider>().value;
}
