# screen_util_example

An example project that displays how to use `Widgetbook` with the [flutter_screenutil package](https://pub.dev/packages/flutter_screenutil).

## How to work with this project

Have a look at the `main.dart` file. 
The `main.dart` file has code for a placeholder App and code that configures a simple Widgetbook using the [widgetbook_generator package](https://pub.dev/packages/widgetbook_generator).

The stops that has been done:
- Setup the [widgetbook_generator package](https://pub.dev/packages/widgetbook_generator) with the `devices` property set for the `@WidgetbookApp` annotation to enable the `FrameAddon`.
- Create a custom `appBuilder` function to inject the `ScreenUtilInit` `Widget` into the Flutter `Widget` tree.
- Use the `ScreenUtil` class within your `Widget` to access its properties. 