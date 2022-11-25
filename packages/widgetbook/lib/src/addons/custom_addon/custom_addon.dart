import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/custom_addon/cusom_addon_selection_provider.dart';
import 'package:widgetbook/src/addons/custom_addon/custom_addon_setting.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_provider.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_selection_provider.dart';
import 'package:widgetbook/src/addons/widgets/addon_option_list.dart';
import 'package:widgetbook/src/navigation/router.dart';

class CustomAddon<T> extends WidgetbookAddOn {
  CustomAddon({
    required CustomAddonSetting<T> setting,
  }) : super(
          icon: const Icon(Icons.dashboard_customize),
          name: 'custom-addon',
          wrapperBuilder: (context, routerData, child) =>
              _wrapperBuilder(context, child, routerData, setting),
          builder: _builder,
          providerBuilder: _providerBuilder,
          selectionCount: _selectionCount,
          getQueryParameter: _getQueryParameter,
        );
}

String _getQueryParameter<T>(BuildContext context) {
  final selectedItems =
      context.read<CustomAddonSelectionProvider<T>>().value.activeData;

  return selectedItems
      .map<T>(
        (e) => e?.toStringAsExponential(2),
      )
      .join(',');
}

int _selectionCount(BuildContext context) {
  return context.read<CustomAddonSelectionProvider>>().value.activeTextScales.length;
}

Widget _builder(BuildContext context) {
  final data = context.watch<CustomAddonSelectionProvider>().value;
  final textScales = data.textScales;
  final activeTextScales = data.activeTextScales;

  return AddonOptionList<double>(
    name: 'Text scales',
    options: textScales,
    selectedOptions: activeTextScales,
    builder: (item) => Text(item.toStringAsFixed(2)),
    onTap: (item) {
      context.read<CustomAddonSelectionProvider>().tapped(item);
      context.read<AddOnProvider>().update();
      navigate(context);
    },
  );
}

Widget _wrapperBuilder<T>(
  BuildContext context,
  Widget child,
  Map<String, dynamic> routerData,
  CustomAddonSetting<T> data,
) {
  final activeTextScalesString = routerData['text-scales'] as String?;
  final selectedTextScales = <T>[];
  if (activeTextScalesString != null) {
    final activeTextScales = activeTextScalesString.split(',');
    final mapTextScales = {
      for (var e in data.textScales) e.toStringAsExponential(2): e
    };

    for (final activeTextScale in activeTextScales) {
      if (mapTextScales.containsKey(activeTextScale)) {
        selectedTextScales.add(mapTextScales[activeTextScale]!);
      }
    }
  }

  final initialData = selectedTextScales.isNotEmpty
      ? data.copyWith(activeData: selectedTextScales.toSet())
      : data;

  return ChangeNotifierProvider(
    create: (_) => CustomAddonSelectionProvider<T>(initialData),
    child: child,
  );
}

SingleChildWidget _providerBuilder(
  BuildContext context,
  int index,
) {
  final selection = context.watch<TextScaleSettingProvider>().value;
  final textScale = selection.activeTextScales.isEmpty
      ? selection.textScales.first
      : selection.activeTextScales.elementAt(index);
  return ChangeNotifierProvider(
    key: ValueKey(textScale),
    create: (context) => TextScaleProvider(textScale),
  );
}

extension TextScaleExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  double get textScale => watch<TextScaleProvider>().value;
}
