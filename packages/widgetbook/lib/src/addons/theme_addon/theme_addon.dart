import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';

class ThemeAddon extends WidgetbookAddOn {
  ThemeAddon({
    required List<ThemeData> themes,
  }) : super(
          icon: const Icon(Icons.theater_comedy),
          name: 'themes',
          wrapperBuilder: (context, child) =>
              _wrapperBuilder(context, child, themes),
          builder: _builder,
          providerBuilder: _providerBuilder,
          selectionCount: _selectionCount,
        );
}

int _selectionCount(BuildContext context) {
  return context.read<ThemeSelectionProvider>().value.activeThemes.length;
}

Widget _builder(BuildContext context) {
  final data = context.watch<ThemeSelectionProvider>().value;
  final themes = data.themes;

  return ListView.separated(
    itemBuilder: (context, index) {
      final item = themes[index];
      return ListTile(
        title: Text(item.toString()),
        onTap: () {
          context.read<ThemeSelectionProvider>().tapped(item);
          context.read<AddOnProvider>().update();
        },
      );
    },
    separatorBuilder: (_, __) {
      // TODO improve this
      return const SizedBox(
        height: 8,
      );
    },
    itemCount: themes.length,
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
