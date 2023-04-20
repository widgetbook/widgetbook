import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

class CustomThemeAddon<T> extends ThemeAddon<T> {
  CustomThemeAddon({
    required super.setting,
    required this.useCaseBuilder,
  });

  final Widget Function(T themeData, Widget useCase) useCaseBuilder;

  @override
  Widget buildUseCaseWrapper(BuildContext context, Widget child) {
    return useCaseBuilder(
      setting.activeTheme.data,
      child,
    );
  }
}

extension CustomThemeExtension on BuildContext {
  T? theme<T>() => getAddonValue<ThemeSetting<T>>()?.activeTheme.data;
}
