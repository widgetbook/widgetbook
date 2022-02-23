<img height=40 src="https://raw.githubusercontent.com/widgetbook/widgetbook/2107e1afe2217e8ecde56c6ade1fd3706c3e6570/docs/assets/WidgetbookLogo.svg">

[![Discord](https://img.shields.io/discord/879618555560218625?color=blue&style=flat-square)](https://discord.com/invite/zT4AMStAJA)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg?style=flat-square)](https://pub.dev/packages/very_good_analysis) 
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?style=flat-square)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?label=test&style=flat-square)


This package contains annotations for [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) with which the generator will create the Widgetbook defined in [package:widgetbook](https://pub.dev/packages/widgetbook). Therefore, this package is a part of making [package:widgetbook](https://pub.dev/packages/widgetbook) easier to setup and maintain.

# Installing this package
This package requires the following dependencies: 

| Package           | Pub |
| ----------------- | --------------------------------- |
| [package:widgetbook](https://pub.dev/packages/widgetbook) | [![Pub Version](https://img.shields.io/pub/v/widgetbook?style=flat-square)](https://pub.dev/packages/widgetbook) |
| [package:widgetbook_annotation](https://pub.dev/packages/widgetbook_annotation) | [![Pub Version](https://img.shields.io/pub/v/widgetbook_annotation?style=flat-square)](https://pub.dev/packages/widgetbook_annotation) |

and the following dev dependencies:

| Package           | Pub |
| ----------------- | --------------------------------- |
| [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) | [![Pub Version](https://img.shields.io/pub/v/widgetbook_generator?style=flat-square)](https://pub.dev/packages/widgetbook_generator) |
| [package:build_runner](https://pub.dev/packages/build_runner) | [![Pub Version](https://img.shields.io/pub/v/build_runner?style=flat-square)](https://pub.dev/packages/build_runner) |

The `pubspec.yaml` file could look like this:

```
dependencies:
  widgetbook_annotation:

dev_dependencies:
  widgetbook:
  build_runner:
  widgetbook_generator:
```

# Available annotations

This package defines the annotations `@WidgetbookApp`, `@WidgetbookUseCase`, and `@WidgetbookTheme`. The annotations and their usage are explained below.

## `@WidgetbookApp`

The annotation `@WidgetbookApp` has to be set only once and is mandatory for the code generation process. It is not important which element is annotated, but the location of the file in which `@WidgetbookApp` is used, defines the folder in which [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) will create the file `app.widgetbook.main`. The `app.widgetbook.main` file contains all the code to run the Widgetbook. 

### Theme support

Since [package:widgetbook](https://pub.dev/packages/widgetbook) supports Material and Cupertino themes as well as a custom themes the annotation can be used with different constructors.

_`WidgetbookApp.material(...)`_

 `@WidgetbookApp.material` should be used if you use a Material theme (`ThemeData`) within your app.

 _`WidgetbookApp.cupertino(...)`_

 `@WidgetbookApp.cupertino` should be used if you use a Cupertino theme (`CupertinoThemeData`) within your app.

  _`WidgetbookApp`_

 `@WidgetbookApp` should be used if you use custom theme within your app. You can use the `themeType` property of the `WidgetbookApp` constructor if you need the generator to create a generic instance. For example:

 ```dart
@WidgetbookApp(themeType: MyCustomTheme)
```

will create the following code:

```dart
class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook<MyCustomTheme>(...);
  }
}
```

### Parameters

The annotation `@WidgetbookApp` (and its named constructors) has one required parameter `name` and multiple optional parameters.

From the `name` parameter, the generator will create the `AppInfo` property of [package:widgetbook](https://pub.dev/packages/widgetbook). Therefore, this value will show in the upper left corner of the Widgetbook. 

_optional parameters_

The optional `devices`, `frames` and `textScaleFactors` properties can be used to set the corresponding parameters documented in [package:widgetbook](https://pub.dev/packages/widgetbook).

### Example

For the following app structure 

```
app
├─ lib
│  ├─ main.dart
│  ├─ app.dart
├─ test
│  ├─ app_test.dart
├─ pubspec.yaml
```

one might add `@WidgetbookApp` to the `App` Widget defined in `app.dart`.

```dart 
@WidgetbookApp.material(
  name: 'Meal App',
  frames: const [
    WidgetbookFrame(
      name: 'Widgetbook',
      allowsDevices: true,
    ),
    WidgetbookFrame(
      name: 'None',
      allowsDevices: false,
    ),
  ],
  devices: [Apple.iPhone12],
  textScaleFactors: [
    1,
    2,
    3,
  ],
  foldersExpanded: true,
  widgetsExpanded: true,
)
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
```

[package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) will then create a new file `app.widgetbook.dart` next to the `app.dart` file. The resulting app structure will look like this:

```
app
├─ lib
│  ├─ main.dart
│  ├─ app.dart
│  ├─ app.widgetbook.dart
├─ test
│  ├─ app_test.dart
├─ pubspec.yaml
```

## `@WidgetbookUseCase`

`@WidgetbookUseCase` allows developers to mark functions as a use case. The `@WidgetbookUseCase` must be applied to a function 

```dart
Widget name(BuildContext context) {  
  return YourWidget()
}
``` 

or a lambda expression

```dart
Widget name(BuildContext context) => YourWidget();
``` 

### Parameters

`@WidgetbookUseCase` requires the two parameters `name` and `type`. 

The `name` parameter specifies how the use case will be displayed in the navigation panel in the Widgetbook.

The `type` parameter specifies to which type of Widget the use case belongs. From this information and the location of the file in which the annotation is used, [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) will create the navigation panel shown on the left side of the Widgetbook.

### Example 

Lets assume that the file structure looks like this

```
app
├─ lib
│  ├─ main.dart
│  ├─ app.dart
│  ├─ tiles
│  │  ├─ awesome_tile.dart
│  ├─ app.widgetbook.dart
├─ test
│  ├─ app_test.dart
├─ pubspec.yaml
```

A use case for `AwesomeTile` located in `/lib/tiles/awesome_tile.dart` can be defined in that file by implementing the following

```dart 
@WidgetbookUseCase(name: 'Default', type: AwesomeTile)
Widget awesomeTileUseCase(BuildContext context) {
  return AwesomeTile();
}

class AwesomeTile extends StatelessWidget {
  const AwesomeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

It often happens that your widget is more complex. In such case, feel free to wrap the widget with whatever you need. This can also be a Provider, Bloc or other state management Widget. 

After generating the code for the Widgetbook, you will find a navigation panel with the following content

```
use cases (Category)
├─ tiles (Folder)
│  ├─ AwesomeTile (WidgetElement)
│  │  ├─ Default (Use Case)
```

If you require multiple use cases for a Widget, feel free to define multiple `@WidgetbookUseCase`s per Widget. The additional use cases will be located in the navigation panel similar to the showcased use case. 

Generator skips top root `src` folder from navigation panel. Many Flutter projects have its source code under a `src` folder, so keep it as a top-level category is unnecessary. If you have the same folder name under `lib` and `src` that folders will be merged. 

## `@WidgetbookTheme`

`@WidgetbookTheme` allows developers to annotated themes of their app. Similar to `@WidgetbookUseCase`, `@WidgetbookTheme` is used on methods returning a `ThemeData` object. 

`@WidgetbookTheme` requires a `name` to identify different themes in the Widgetbook UI. You can also define `isDefault` to true if you want the theme to be the default on startup. 

### Example

```dart
@WidgetbookTheme.dark()
ThemeData getDarkTheme() => ThemeData(
      primarySwatch: Colors.blue,
    );
```

## Localization annotations

Widgetbook allows developers to annotate locales and localization delegates supported by your app. 

### `@WidgetbookLocales`

Use `@WidgetbookLocales` to define the supported locales: 

```dart
@WidgetbookLocales()
final locales = [
  Locale('en'),
  Locale('de'),
  Locale('fr'),
];
```

### `@WidgetbookLocalizationDelegates`

Use `@WidgetbookLocalizationDelegates` to define the supported localization delegates:

```dart
@WidgetbookLocalizationDelegates()
final delegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
```

## Builder annotations

Widgetbook supports builder functions to customize how the use cases, themes and localization is build. Therefore, this package features annotations for all the builder functions available. 

The annotations are:

- `@WidgetbookDeviceFrameBuilder`
- `@WidgetbookLocalizationBuilder`
- `@WidgetbookScaffoldBuilder`
- `@WidgetbookThemeBuilder`
- `@WidgetbookUseCaseBuilder`

### How to define an annotated builder function

Make sure to define a global function with the parameters of the builder function you'd like to define. 

### Example 
```dart
@WidgetbookDeviceFrameBuilder()
DeviceFrameBuilderFunction frameBuilder = (
  BuildContext context,
  Device device,
  WidgetbookFrame frame,
  Orientation orientation,
  Widget child,
) { ... }
```

# Let us know how you feel about Widgetbook

We are funded and aim to shape `Widgetbook` to your (and your team's) needs. If you have questions, feature requests or issues let us know on [Discord](https://discord.gg/zT4AMStAJA) or [GitHub](https://github.com/widgetbook/widgetbook) or book a call with the founders via [Calendly](https://calendly.com/widgetbook/call). We're looking forward to build a community and discuss your feedback on our channel! 💙
