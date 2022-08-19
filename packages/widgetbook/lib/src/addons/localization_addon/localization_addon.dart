import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_data.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_provider.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_selection.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_selection_provider.dart';

export './localization_data.dart';
export './localization_selection.dart';

class LocalizationAddon extends WidgetbookAddOn {
  LocalizationAddon({
    required LocalizationSelection data,
  }) : super(
          icon: const Icon(Icons.translate),
          name: 'Localization',
          wrapperBuilder: (context, child) =>
              _wrapperBuilder(context, child, data),
          builder: _builder,
          providerBuilder: _providerBuilder,
          selectionCount: _selectionCount,
        );
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

  return ListView.separated(
    itemBuilder: (context, index) {
      final item = locales[index];
      return ListTile(
        title: Text(item.toString()),
        onTap: () {
          context.read<LocalizationSelectionProvider>().tapped(item);
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
    itemCount: locales.length,
  );
}

Widget _wrapperBuilder(
  BuildContext context,
  Widget child,
  LocalizationSelection data,
) {
  return ChangeNotifierProvider(
    create: (_) => LocalizationSelectionProvider(data),
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
