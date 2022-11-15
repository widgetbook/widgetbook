import 'package:custom_theme_example/app_theme.dart';
import 'package:custom_theme_example/awesome_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotReload());
}

// @anno.WidgetbookTheme(name: 'Default')
AppThemeData themeData = AppThemeData(
  color: Colors.yellow,
);

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  GoRouter getRouter(Widget child) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => child,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final widgetbookTheme = WidgetbookTheme(
      data: themeData,
      name: 'App Theme',
    );

    return Widgetbook(
        addons: [
          CustomThemeAddon<AppThemeData>(
            themeSetting: CustomThemeSetting(
              themes: [
                widgetbookTheme,
              ],
              activeThemes: {
                widgetbookTheme,
              },
            ),
          ),
        ],
        appInfo: AppInfo(name: 'Custom Theme Example'),
        categories: [
          WidgetbookCategory(
            name: 'Default',
            widgets: [
              WidgetbookComponent(
                name: 'Awesome Widget',
                useCases: [
                  WidgetbookUseCase(
                    name: 'Default',
                    builder: (context) => const AwesomeWidget(),
                  )
                ],
              ),
            ],
          )
        ],
        //THis did work but the theme is not injected in the widget tree
        // still  looking into it
        appBuilder: (context, child) => child

        //This Didn't work
        //We should investigate why.

        //   final router = getRouter(child);
        //   // This is actually important
        //   final frameBuilder = context.frameBuilder;
        //   return frameBuilder.builder(
        //       context,
        //       AppTheme(
        //           data: context.theme(),
        //           child: WidgetsApp.router(
        //             color: context.theme<AppThemeData>().color,
        //             builder: (context, childWidget) {
        //               return childWidget ?? child;
        //             },
        //             debugShowCheckedModeBanner: false,
        //             routeInformationParser: router.routeInformationParser,
        //             routerDelegate: router.routerDelegate,
        //           )));
        // },
        );
  }
}
