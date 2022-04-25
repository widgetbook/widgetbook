<img height=40 src="https://raw.githubusercontent.com/widgetbook/widgetbook/2107e1afe2217e8ecde56c6ade1fd3706c3e6570/docs/assets/WidgetbookLogo.svg">

[![Discord](https://img.shields.io/discord/879618555560218625?color=blue&style=flat-square)](https://discord.com/invite/zT4AMStAJA)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg?style=flat-square)](https://pub.dev/packages/very_good_analysis) 
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?style=flat-square)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?label=test&style=flat-square)

A flutter package which helps developers cataloguing their widgets, testing them quickly on multiple devices and themes, and sharing them easily with designers and clients. Inspired by Storybook.js.

<p align="center">
<img src="https://raw.githubusercontent.com/widgetbook/widgetbook/main/docs/assets/Screenshot.jpg" alt="Widgetbook Screenshot" />
</p>

# See it in action!

Check out the `Widgetbook` with the example app on our [homepage](https://demo.widgetbook.io). Furthermore, you can [check out the code of the app at github](https://github.com/widgetbook/widgetbook/tree/main/examples). 

# Other packages

[package:widgetbook](https://pub.dev/packages/widgetbook) can be used with [package:widgetbook_annotation](https://pub.dev/packages/widgetbook_annotation) and [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) to make setting up and maintaining Widgetbook easier. Check out the other packages:

| Package           | Pub |
| ----------------- | --------------------------------- |
| [package:widgetbook](https://pub.dev/packages/widgetbook) | [![Pub Version](https://img.shields.io/pub/v/widgetbook?style=flat-square)](https://pub.dev/packages/widgetbook) |
| [package:widgetbook_annotation](https://pub.dev/packages/widgetbook_annotation) | [![Pub Version](https://img.shields.io/pub/v/widgetbook_annotation?style=flat-square)](https://pub.dev/packages/widgetbook_annotation) |
| [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) | [![Pub Version](https://img.shields.io/pub/v/widgetbook_generator?style=flat-square)](https://pub.dev/packages/widgetbook_generator) |

# Usage

```dart
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotreloadWidgetbook());
}

class HotreloadWidgetbook extends StatelessWidget {
  const HotreloadWidgetbook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          widgets: [
            WidgetbookComponent(
              name: 'Button',
              useCases: [
                WidgetbookUseCase(
                  name: 'elevated',
                  builder: (context) => ElevatedButton(
                    onPressed: () {},
                    child: const Text('Widgetbook'),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: ThemeData.light(),
        ),
        WidgetbookTheme(
          name: 'Dark', 
          data: ThemeData.dark(),
        ),
      ],
      appInfo: AppInfo(name: 'Example'),
    );
  }
}
```

# Getting Started

This package provides a flutter widget called `Widgetbook` in which custom widgets from your app can be injected.

## Setting up

First, add the dependency to your `pubspec.yaml` file:

```yaml
# pubspec.yaml
dev_dependencies:
  widgetbook:
```

Since the Widgetbook is launched as a separate app, it is recommended to create another `main` method. This enables you to switch between your app and `Widgetbook` at any time. You can even launch your app and `Widgetbook` simultaneously.

The folder structure might look like this:

```
example_app
├─ lib
│  ├─ main.dart
├─ widgetbook
│  ├─ main.dart
│  ├─ widgetbook.dart
├─ pubspec.yaml
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

# Constructors

`Widgetbook` allows developers to define whatever `Theme` they have defined for their app. To accompany every theme and the ones defined by Flutter, the following constructors exist: 

Theme | Constructor | Defaults to
------------ | ------------- | ------------- 
Custom Theme | `Widgetbook<YourTheme>` | ➖
Material | `Widgetbook.material` | `Widgetbook<ThemeData>`
Cupertino | `Widgetbook.cupertino` | `Widgetbook<CupertinoThemeData>`


As you can see from the constructor definitions, `Widgetbook` allows to define your Theme type to accompany any implementation. However, most developers will likely use `Widgetbook.material` as shown [in the example](#Usage) above.

# Knobs

<p align="center">
<img src="https://raw.githubusercontent.com/widgetbook/widgetbook/main/docs/assets/KnobsAnimated.gif" alt="Knobs" />
</p>

Knobs can be used to dynamically change the parameters passed to a usecase.

```dart
WidgetbookUseCase(
  name: 'elevated',
  builder: (context) => MyHomePage(
    title: context.knobs.text(
      label: 'Title Label',
      initialValue: 'HomePage',
    ),
  )
)
```

## Available Knobs



| Name            | Type    |
|-----------------|---------|
| boolean         | bool    |
| nullableBoolean | bool?   |
| text            | String  |
| nullableText    | String? |
| slider          | double  |
| nullableSlider  | double? |
| number          | num     |
| nullableNumber  | num?    |
| options         | T       |

You can see an example of this and different knobs available
[here](examples/knobs_example/lib/widgetbook.dart).

# Properties

`Widgetbook` defines various properties to customize how your `Widget`s will be rendered.

## `categories`

Your widgets can be catalogued by using different `Organizer`s. The available organizers are: `WidgetbookCategory`, `WidgetbookFolder`, `WidgetbookComponent` and `WidgetbookUseCase`.

Both `WidgetbookCategory` and `WidgetbookFolder` can contain sub folders and `WidgetbookComponent` elements. However, `WidgetbookComponent` can only contain `WidgetbookUseCase`s. 

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
            WidgetbookComponent(
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
                WidgetbookComponent(
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

## `appInfo`

The `appInfo` property allows users to label the `Widgetbook` in case you are maintaining more than one `Widgetbook` for multiple projects. Customize `Widgetbook`'s name according to the project by using appInfo:

```dart
Widgetbook.material(
  appInfo: AppInfo(
    name: 'Your apps name',
  ),
)
```

## Localization

Widgetbook defines the two properties `supportedLocales` and `localizationsDelegates` to support localization of `Widget`s. These values behave as described in [Flutter Internationalization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization).

```dart
Widgetbook.material(
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    Locale('en'), // English, no country code
    Locale('es'), // Spanish, no country code
  ],
)
```

## `themes`

Import your app's theme for a realistic preview by using `Widgetbook`'s `theme` property:
```dart
Widgetbook.material(
   themes: [
    WidgetbookTheme(
      name: 'Light',
      data: ThemeData.light(),
    ),
    WidgetbookTheme(
      name: 'Dark',
      data: ThemeData.dark(),
    ),
  ],
)
```

## `devices`

Customize the preview by defining preview devices: 

```dart
Widgetbook.material(
  devices: [
    Apple.iPhone11,
    Samsung.s21ultra,
  ]
)
```

Right now, there is a predefined list of devices. If you need more devices, you can either add them on your own or let us know which ones you need in our [Discord](https://discord.gg/zT4AMStAJA).

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

## `frames`

The `frames` property allows developers to define different ways of how the frame of a device is visualized. The following `WidgetbookFrame`s are defined:

`WidgetbookFrame` | Comment | Is default
------------ | ------------- | ------------- 
`WidgetbookFrame.defaultFrame` | The default frame of `Widgetbook` | ✅ | 
`WidgetbookFrame.noFrame` | No frame - this just shows the use case without any device restrictions | ✅ |
`WidgetbookFrame.deviceFrame` | A frame known from the [device_frame](https://pub.dev/packages/device_frame) package | ✅ |

If the Device Frame option is active, the Widgetbook devices will be mapped to the devices of [device_frame](https://pub.dev/packages/device_frame).

## `textScaleFactors`

The `textScaleFactors` property allows you to define a list of different text scales which are injected (and can then be accessed) via the `MediaQuery`. The list defaults to `textScaleFactors` of `[ 1.0 ]`. 

## Builders

`Widgetbook` exposes various builder functions to allow customization of how `WidgetbookUseCase`s are displayed.

### `deviceFrameBuilder`

The `deviceFrameBuilder` in combination with the `frames` property can be used to add your or an existing implementation of a device frame: 

For the [device_frame](https://pub.dev/packages/device_frame) package this can look like this:

```dart
Widgetbook.material(
  deviceFrameBuilder: (context, device, renderMode, child) {
    if (renderMode == DeviceFrame.deviceFrame()) {
      return frame.DeviceFrame(
        device: frame.Devices.ios.iPhone12,
        screen: child,
      );
    }

    // default to no device frame
    return child;
  },
)
```

### `localizationBuilder`

The default of `localizationBuilder` is defined as: 

```dart
(
  BuildContext context,
  List<Locale> supportedLocales,
  List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  Locale activeLocale,
  Widget child,
) {
  if (localizationsDelegates != null) {
    return Localizations(
      locale: activeLocale,
      delegates: localizationsDelegates,
      child: child,
    );
  }

  return child;
};
```

### `themeBuilder`

The `themeBuilder` allows you to inject theme data into the `Widget` tree. An implementation for `CupertinoThemeData` could look like this:

```dart
Widgetbook<CupertinoThemeData>(
  themeBuilder: (
    BuildContext context,
    CupertinoThemeData theme,
    Widget child,
  ) {
    return CupertinoTheme(
      data: theme,
      child: child,
    );
  },
)
```

### `scaffoldBuilder` and `useCaseBuilder`

Both the `scaffoldBuilder` and `useCaseBuilder` can be used to wrap the `Widget` with e.g. a `Scaffold` or some other `Widget` like a `Center`, `Container` or `Padding`.

# Supported Flutter version

We are currently aiming to support the latest flutter version.

# Using Widgetbook for a package

A lot of app projects implement dedicated packages for UI components. These packages often do not define a (desktop) app. Therefore, it's hard to use Widgetbook for these packages. This section will explain how you can get Widgetbook running in such a scenario. 

Let's assume you have set up a monorepo with the following folder structure with two packages `ui_components` and `core_api`:

```
monorepo
├─ docs
├─ packages
│  ├─ ui_components
│  ├─ core_api
```

To create a widgetbook for the `ui_components` package, we recommend to create a new folder named `widgetbooks` in the root of the repository and add a flutter (desktop) app named `ui_components_widgetbook`. The folder structure of your repository will look like this:

```
monorepo
├─ docs
├─ packages
│  ├─ ui_components
│  ├─ core_api
├─ widgetbooks
│  ├─ ui_components_widgetbook
│  │  ├─ lib
│  │  ├─ macos
│  │  ├─ pubspec.yaml
```

Make sure to modify `widgetbooks/ui_components_widgetbook/pubspec.yaml` to depend on `ui_components`: 

`pubspec.yaml:`
```
dependencies:
  ui_components:
    path: ../../packages/ui_components
```

You can now use all exported `Widget`s from your library to compose your Widgetbook.

# Known Issues

- Hot reloading on web is currently not working properly. This is due to the fact that hot reloading is actually a restart. The problem is tracked in [widgetbook/issues/4](https://github.com/widgetbook/widgetbook/issues/4). For now we recommended to use MacOS or Windows as a platform for development.

# Let us know how you feel about Widgetbook

We are funded and aim to shape `Widgetbook` to your (and your team's) needs. If you have questions, feature requests or issues let us know on [Discord](https://discord.gg/zT4AMStAJA) or [GitHub](https://github.com/widgetbook/widgetbook). We're looking forward to build a community and discuss your feedback on our channel! 💙
