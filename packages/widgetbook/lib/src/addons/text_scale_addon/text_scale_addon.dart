import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_provider.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_selection_provider.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_setting.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class TextScaleAddon extends WidgetbookAddOn {
  TextScaleAddon({
    required TextScaleSetting setting,
  }) : super(
          name: 'text-scales',
          wrapperBuilder: (context, routerData, child) =>
              _wrapperBuilder(context, child, routerData, setting),
          builder: _builder,
          providerBuilder: _providerBuilder,
          getQueryParameter: _getQueryParameter,
        );
}

Map<String, String> _getQueryParameter(BuildContext context) {
  final selectedItem =
      context.read<TextScaleSettingProvider>().value.activeTextScale;

  return {
    'text-scale': selectedItem.toStringAsFixed(2),
  };
}

Widget _builder(BuildContext context) {
  final data = context.watch<TextScaleSettingProvider>().value;
  final textScales = data.textScales;
  final activeTextScale = data.activeTextScale;

  return Setting(
    name: 'Text scale',
    child: DropdownSetting<double>(
      options: textScales,
      initialSelection: activeTextScale,
      optionValueBuilder: (scale) => scale.toStringAsFixed(2),
      onSelected: (item) {
        context.read<TextScaleSettingProvider>().tapped(item);
        context.read<AddOnProvider>().update();
        context.goTo(queryParams: _getQueryParameter(context));
      },
    ),
  );
}

Widget _wrapperBuilder(
  BuildContext context,
  Widget child,
  Map<String, dynamic> routerData,
  TextScaleSetting data,
) {
  final double? selectedTextScale = parseRouterData(
    name: 'text-scale',
    routerData: routerData,
    mappedData: {for (var e in data.textScales) e.toStringAsFixed(2): e},
  );

  final initialData = selectedTextScale != null
      ? data.copyWith(activeTextScale: selectedTextScale)
      : data;

  return ChangeNotifierProvider(
    key: ValueKey(initialData),
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
  double? get textScale => watch<TextScaleProvider?>()?.value;
}
