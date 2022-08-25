import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_data.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_provider.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_selection.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_selection_provider.dart';
import 'package:widgetbook/src/addons/widgets/addon_option_list.dart';
import 'package:widgetbook/src/navigation/router.dart';

export './localization_data.dart';
export './localization_selection.dart';

class LocalizationAddon extends WidgetbookAddOn {
  LocalizationAddon({
    required LocalizationSelection data,
  }) : super(
          icon: const Icon(Icons.translate),
          name: 'localization',
          wrapperBuilder: (context, routerData, child) =>
              _wrapperBuilder(context, child, routerData, data),
          builder: _builder,
          providerBuilder: _providerBuilder,
          selectionCount: _selectionCount,
          getQueryParameter: _getQueryParameter,
        );
}

String _getQueryParameter(BuildContext context) {
  final selectedItems =
      context.read<LocalizationSelectionProvider>().value.activeLocales;

  return selectedItems.map((e) => e.languageCode).join(',');
}

int _selectionCount(BuildContext context) {
  return context
      .read<LocalizationSelectionProvider>()
      .value
      .activeLocales
      .length;
}

Widget _builder(BuildContext context) {
  final data = context.watch<LocalizationSelectionProvider>().value;
  final locales = data.locales;
  final activeLocales = data.activeLocales;

  return AddonOptionList<Locale>(
    name: 'Locales',
    options: locales,
    selectedOptions: activeLocales,
    builder: (item) => Text(item.toString()),
    onTap: (item) {
      context.read<LocalizationSelectionProvider>().tapped(item);
      context.read<AddOnProvider>().update();
      navigate(context);
    },
  );
}

Widget _wrapperBuilder(
  BuildContext context,
  Widget child,
  Map<String, dynamic> routerData,
  LocalizationSelection data,
) {
  final activeLocalesString = routerData['locales'] as String?;
  final selectedLocales = <Locale>[];
  if (activeLocalesString != null) {
    final activeLocales = activeLocalesString.split(',');
    final mapLocales = {for (var e in data.locales) e.languageCode: e};

    for (final activeLocale in activeLocales) {
      if (mapLocales.containsKey(activeLocale)) {
        selectedLocales.add(mapLocales[activeLocale]!);
      }
    }
  }

  final initialData = selectedLocales.isNotEmpty
      ? data.copyWith(activeLocales: selectedLocales.toSet())
      : data;

  return ChangeNotifierProvider(
    create: (_) => LocalizationSelectionProvider(initialData),
    child: child,
  );
}

SingleChildWidget _providerBuilder(
  BuildContext context,
  int index,
) {
  final selection = context.watch<LocalizationSelectionProvider>().value;
  final locale = selection.activeLocales.isEmpty
      ? selection.locales.first
      : selection.activeLocales.elementAt(index);
  return ChangeNotifierProvider(
    create: (context) => LocalizationProvider(
      LocalizationData(
        activeLocale: locale,
        supportedLocales: selection.locales,
        localizationsDelegates: selection.localizationsDelegates,
      ),
    ),
  );
}

extension LocalizationExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  LocalizationData get localization => watch<LocalizationProvider>().value;
}
