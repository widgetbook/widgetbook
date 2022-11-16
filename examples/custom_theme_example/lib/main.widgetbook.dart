import 'package:custom_theme_example/app_theme.dart';
import 'package:custom_theme_example/awesome_widget.dart';
import 'package:custom_theme_example/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;

void main() {
  runApp(const HotReload());
}

@anno.WidgetbookTheme(name: 'Default')
AppThemeData themeData = AppThemeData(
  color: Colors.blue,
);
@anno.WidgetbookTheme(name: 'Appthem2')
AppThemeData themeData2 = AppThemeData(
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
    final widgetbookTheme2 = WidgetbookTheme(
      data: themeData2,
      name: 'App Theme2',
    );
    final devices = [
      Apple.iPhone11,
      Apple.iPhone12,
      const Device.special(
        name: 'Test',
        resolution: Resolution(
          nativeSize: DeviceSize(width: 400, height: 400),
          scaleFactor: 1,
        ),
      ),
    ];
    final deviceFrameBuilder = DeviceFrameBuilder(
      devices: devices,
    );
    final activeFrameBuilder = WidgetbookFrameBuilder(
      devices: devices,
    );
    return Widgetbook(
        addons: [
          DeviceAddon(
            data: DeviceSelection(
              activeFrameBuilder: activeFrameBuilder,
              frameBuilders: [
                activeFrameBuilder,
                deviceFrameBuilder,
              ],
            ),
          ),
          CustomThemeAddon<AppThemeData>(
            themeSetting: CustomThemeSetting.firstAsSelected(
              themes: [widgetbookTheme, widgetbookTheme2],
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
              WidgetbookComponent(
                name: 'App Launch Screen',
                useCases: [
                  WidgetbookUseCase(
                    name: 'Default',
                    builder: (context) => const MyHomePage(
                      title: 'test',
                    ),
                  )
                ],
              ),
            ],
          )
        ],
        //THis did work but the theme is not injected in the widget tree
        // still  looking into it
        appBuilder: (context, child) {
          final frameBuilder = context.frameBuilder;
          final theme = context.customTheme<AppThemeData>();
          return AppTheme(
            data: theme,
            child: frameBuilder.builder(context, child),
          );
        }

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
