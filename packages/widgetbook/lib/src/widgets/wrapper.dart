import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/providers/injected_theme_provider.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';

import 'package:widgetbook/src/utils/utils.dart';
import 'package:widgetbook/src/widgets/controls_bar.dart';
import 'package:widgetbook/src/widgets/no_theme.dart';
import 'package:widgetbook/src/widgets/story_render.dart';

class Editor extends StatelessWidget {
  const Editor({
    Key? key,
  }) : super(key: key);

  bool isSelectedThemeDefined(BuildContext context) {
    final injectedThemeState = InjectedThemeProvider.of(context)!.state;
    final themeState = ThemeProvider.of(context)!.state;

    if (themeState == ThemeMode.light &&
        injectedThemeState.isLightThemeDefined) {
      return true;
    }

    if (themeState == ThemeMode.dark && injectedThemeState.isDarkThemeDefined) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ControlsBar(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: Radii.defaultRadius,
              color: context.colorScheme.surface,
            ),
            child: isSelectedThemeDefined(context)
                ? const StoryRender()
                : const NoTheme(),
          ),
        ),
      ],
    );
  }
}
