import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_data.dart';
import 'package:widgetbook/src/addons/localization_addon/localization_provider.dart';

export './localization_data.dart';

class LocalizationAddon extends WidgetbookAddOn {
  LocalizationAddon({
    required LocalizationData data,
  }) : super(
          icon: const Icon(Icons.translate),
          name: 'Localization',
          wrapperBuilder: (context, child) =>
              _wrapperBuilder(context, child, data),
          builder: _builder,
        );
}

Widget _builder(BuildContext context) {
  final data = context.watch<LocalizationProvider>().value;
  final locales = data.locales;

  void update(LocalizationData data) =>
      context.read<LocalizationProvider>().value = data;

  return ListView.separated(
    itemBuilder: (context, index) {
      final item = locales[index];
      return ListTile(
        title: Text(item.toString()),
        onTap: () {
          update(data.copyWith(activeLocale: item));
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
  LocalizationData data,
) {
  return ChangeNotifierProvider(
    create: (_) => LocalizationProvider(data),
    child: child,
  );
}

extension Localization on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  LocalizationData get localization => watch<LocalizationProvider>().value;
}
