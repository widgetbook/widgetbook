<img height=40 src="https://raw.githubusercontent.com/widgetbook/widgetbook/2107e1afe2217e8ecde56c6ade1fd3706c3e6570/docs/assets/WidgetbookLogo.svg">

[![Discord](https://img.shields.io/discord/879618555560218625?color=blue&style=flat-square)](https://discord.com/invite/zT4AMStAJA)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg?style=flat-square)](https://pub.dev/packages/very_good_analysis) 
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?style=flat-square)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?label=test&style=flat-square)
[![youtube: How to](https://img.shields.io/badge/YouTube-What%20is%20Widgetbook%3F-d05454?style=flat-square)](https://www.youtube.com/watch?v=vs3ocjMsl7s)
[![youtube: How to](https://img.shields.io/badge/YouTube-How%20to%20%20use%20Widgetbook%3F-d05454?style=flat-square)](https://www.youtube.com/watch?v=qcTZxJDLEAE) 
[![youtube: How to](https://img.shields.io/badge/YouTube-How%20to%20%20use%20Widgetbook%20Generator%3F-d05454?style=flat-square)](https://www.youtube.com/watch?v=dh8hxgtbjtk) 

A flutter package which helps developers cataloguing their widgets, testing them quickly on multiple devices and themes, and sharing them easily with designers and clients. Inspired by Storybook.js and flutterbook.

<p align="center">
<img src="https://media.githubusercontent.com/media/widgetbook/widgetbook/main/docs/assets/Screenshot.png" alt="Widgetbook Screenshot" />
</p>

# See it in action!

Check out the `Widgetbook` with the example app on our [github page](https://widgetbook.github.io). We also have introduction videos for [What is Widgetbook?](https://www.youtube.com/watch?v=vs3ocjMsl7s), [How to use Widgetbook?](https://www.youtube.com/watch?v=qcTZxJDLEAE) and [How to use Widgetbook generator?](https://www.youtube.com/watch?v=dh8hxgtbjtk).
Furthermore, you can [check out the code of the app at github](https://github.com/widgetbook/widgetbook/tree/main/example). 

# Other packages

[package:widgetbook](https://pub.dev/packages/widgetbook) can be used with [package:widgetbook_annotation](https://pub.dev/packages/widgetbook_annotation) and [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) to make setting up and maintaining Widgetbook easier. Check out the other packages:

| Package           | Pub |
| ----------------- | --------------------------------- |
| [package:widgetbook](https://pub.dev/packages/widgetbook) | [![Pub Version](https://img.shields.io/pub/v/widgetbook?style=flat-square)](https://pub.dev/packages/widgetbook) |
| [package:widgetbook_annotation](https://pub.dev/packages/widgetbook_annotation) | [![Pub Version](https://img.shields.io/pub/v/widgetbook_annotation?style=flat-square)](https://pub.dev/packages/widgetbook_annotation) |
| [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) | [![Pub Version](https://img.shields.io/pub/v/widgetbook_generator?style=flat-square)](https://pub.dev/packages/widgetbook_generator) |

# Getting Started

This package provides a flutter widget called `Widgetbook` in which custom widgets from your app can be injected.

## Setting up

First, add the dependency to your pubspec.yaml file:

```yaml
# pubspec.yaml
dev_dependencies:
  widgetbook:
```

Since the Widgetbook is launched as a separate app, it is recommended to create another main method. This enables you to switch between your app and the `Widgetbook` at any time. You can even launch your app and `Widgetbook` simultaneously.

The folder structure might look like this:
```
example_app
+ lib
+--- main.dart
+ widgetbook
+--- main.dart
+--- widgetbook.dart
```

The `widgetbook/widgetbook.dart` file contains the `Widgetbook` wrapped within a stateless widget that enables hot reloading. The code looks like this: 

```dart
class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(...);
  }
}
```

In the `widgetbook/main.dart` run the `HotReload` widget:

```dart
void main() {
  runApp(HotReload());
}
```

## Run the Widgetbook

`Widgetbook` is supported on the following environments.

Environment | Status | Comment
------------ | ------------- | ------------- 
MacOS | ✅ | 
Windows | ✅ |
Linux | ✅ |
Web | ✅ | No hot reload, but hot restart (see [Issue 4](https://github.com/widgetbook/widgetbook/issues/4))
Mobile | ➖ | Will run, but is not optimized. If you see a usecase for `Widgetbook` on mobile let us know. 

See the [Desktop support for Flutter](https://flutter.dev/desktop) page for setup instructions.

Run the `Widgetbook` main method by executing `flutter run -t widgetbook/main.dart`.

> **NOTE:** If you are using [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) see the documentation on how to run Widgetbook.

# Inject your widgets

Your widgets can be organized into different areas of interest by using `WidgetbookCategory`, `WidgetbookFolder`, `WidgetbookWidget` and `WidgetbookUseCase`.

```dart
class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          widgets: [
            WidgetbookWidget(
              name: '$CustomWidget',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => CustomWidget(),
                ),
              ],
            ),
          ],
          folders: [
            WidgetbookFolder(
              name: 'Texts',
              widgets: [
                WidgetbookWidget(
                  name: 'Normal Text',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default',
                      builder: (context) => Text(
                        'The brown fox ...',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      appInfo: AppInfo(
        name: 'Widgetbook Example',
      ),
    );
  }
}
```

## Set Widgetbook name

Customize `Widgetbook`'s name according to the project by using appInfo:

```dart
Widgetbook(
  appInfo: AppInfo(
    name: 'Your apps name',
  ),
)
```

## Adding Themes

Import your app's theme for a realistic preview by using `Widgetbook`'s `lightTheme` and `darkTheme` properties:
```dart
Widgetbook(
  lightTheme: lightTheme,
  darkTheme: darkTheme,
)
```

A preview in Widgetbook's light or dark mode is only shown when the appropriate theme is set. 

If you are in development and haven't defined a theme yet, you can use `ThemeData.light()` or `ThemeData.dark()` to use a default theme.

## Add devices

Customize the preview by defining preview devices: 

```dart
Widgetbook(
  devices: [
    Apple.iPhone11,
    Apple.iPhone12,
    Samsung.s10,
    Samsung.s21ultra,
  ]
)
```

Right now there is a predefinied short list of devices but let us know which you need in our [Discord](https://discord.gg/zT4AMStAJA). We will extend the list of predefinied devices in the future!

### Define your own device

You can also define your own device by using the `Device` class:

```dart
Device(
  name: 'Custom Device',
  resolution: Resolution.dimensions(
    width: 500,
    height: 500,
    scaleFactor: 2,
  ),
  type: DeviceType.tablet,
),
```

# Known Issues

- Hot reloading on web is currently not working properly. This is due to the fact that hot reloading is actually a restart. The problem is tracked in [widgetbook/issues/4](https://github.com/widgetbook/widgetbook/issues/4). For now we recommended to use MacOS or Windows as a platform for development.

# Let us know how you feel about Widgetbook

We are funded and aim to shape `Widgetbook` to your (and your team's) needs. If you have questions, feature requests or issues let us know on [Discord](https://discord.gg/zT4AMStAJA) or [GitHub](https://github.com/widgetbook/widgetbook) or book a call with the founders via [Calendly](https://calendly.com/widgetbook/call). We're looking forward to build a community and discuss your feedback on our channel! 💙
