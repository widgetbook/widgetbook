import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_provider.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_selection_provider.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_setting.dart';
import 'package:widgetbook/src/addons/utilities/utilities.dart';
import 'package:widgetbook/src/addons/widgets/addon_option_list.dart';
import 'package:widgetbook/src/navigation/router.dart';

class TextScaleAddon extends WidgetbookAddOn {
  TextScaleAddon({
    required TextScaleSetting setting,
  }) : super(
          icon: const Icon(Icons.text_fields_outlined),
          name: 'text-scales',
          wrapperBuilder: (context, routerData, child) =>
              _wrapperBuilder(context, child, routerData, setting),
          builder: _builder,
          providerBuilder: _providerBuilder,
          getQueryParameter: _getQueryParameter,
        );
}

Map _getQueryParameter(BuildContext context) {
  final selectedItem =
      context.read<TextScaleSettingProvider>().value.activeTextScale;

  return <String, dynamic>{'selection': selectedItem.toStringAsExponential(2)};
}

Widget _builder(BuildContext context) {
  final data = context.watch<TextScaleSettingProvider>().value;
  final textScales = data.textScales;
  final activeTextScale = data.activeTextScale;

  return AddonOptionList<double>(
    name: 'Text scales',
    options: textScales,
    selectedOption: activeTextScale,
    builder: (item) => Text(item.toStringAsFixed(2)),
    onTap: (item) {
      context.read<TextScaleSettingProvider>().tapped(item);
      context.read<AddOnProvider>().update();
      navigate(context);
    },
  );
}

Widget _wrapperBuilder(
  BuildContext context,
  Widget child,
  Map<String, dynamic> routerData,
  TextScaleSetting data,
) {
  final activeTextScalesStringData = routerData['text-scales'] as String?;

  final activeTextScalesString = activeTextScalesStringData != null
      ? context.jsonToString(
          data: activeTextScalesStringData,
          addonItem: 'selection',
        )
      : null;

  double? selectedTextScale;

  if (activeTextScalesString != null) {
    final activeTextScales = activeTextScalesString.split(',');
    final mapTextScales = {
      for (var e in data.textScales) e.toStringAsExponential(2): e
    };

    for (final activeTextScale in activeTextScales) {
      if (mapTextScales.containsKey(activeTextScale)) {
        selectedTextScale = mapTextScales[activeTextScale];
      }
    }
  }

  final initialData = selectedTextScale != null
      ? data.copyWith(activeTextScale: selectedTextScale)
      : data;

  return ChangeNotifierProvider(
    create: (_) => TextScaleSettingProvider(initialData),
    child: child,
  );
}

SingleChildWidget _providerBuilder(
  BuildContext context,
) {
  final selection = context.watch<TextScaleSettingProvider>().value;
  final textScale = selection.activeTextScale;

  return ChangeNotifierProvider(
    key: ValueKey(textScale),
    create: (context) => TextScaleProvider(textScale),
  );
}

extension TextScaleExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  double get textScale => watch<TextScaleProvider>().value;
}
