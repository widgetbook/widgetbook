import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_provider.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_selection_provider.dart';
import 'package:widgetbook/src/addons/widgets/addon_option_list.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/widgetbook.dart';

class LocalizationAddon extends WidgetbookAddOn {
  LocalizationAddon({
    required LocalizationSetting setting,
  }) : super(
          icon: const Icon(Icons.translate),
          name: 'localization',
          wrapperBuilder: (context, routerData, child) =>
              _wrapperBuilder(context, child, routerData, setting),
          builder: _builder,
          providerBuilder: _providerBuilder,
          getQueryParameter: _getQueryParameter,
        );
}

Map<String, String> _getQueryParameter(BuildContext context) {
  final selectedItem =
      context.read<LocalizationSettingProvider>().value.activeLocale;

  return {'locale': selectedItem.languageCode};
}

Widget _builder(BuildContext context) {
  final data = context.watch<LocalizationSettingProvider>().value;
  final locales = data.locales;
  final activeLocale = data.activeLocale;

  return AddonOptionList<Locale>(
    name: 'Locales',
    options: locales,
    selectedOption: activeLocale,
    builder: (item) => Text(item.toString()),
    onTap: (item) {
      context.read<LocalizationSettingProvider>().tapped(item);
      context.read<AddOnProvider>().update();
      navigate(context);
    },
  );
}

Widget _wrapperBuilder(
  BuildContext context,
  Widget child,
  Map<String, dynamic> routerData,
  LocalizationSetting data,
) {
  final Locale? selectedLocale = parseRouterData(
    name: 'locale',
    routerData: routerData,
    mappedData: {for (var e in data.locales) e.languageCode: e},
  );

  final initialData = selectedLocale != null
      ? data.copyWith(activeLocale: selectedLocale)
      : data;

  return ChangeNotifierProvider(
    key: ValueKey(initialData),
    create: (_) => LocalizationSettingProvider(initialData),
    child: child,
  );
}

SingleChildWidget _providerBuilder(
  BuildContext context,
) {
  final selection = context.watch<LocalizationSettingProvider>().value;
  final locale = selection.activeLocale;
  return ChangeNotifierProvider(
    key: ValueKey(locale),
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
