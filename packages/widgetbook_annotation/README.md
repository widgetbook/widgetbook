[![Discord](https://img.shields.io/discord/879618555560218625?color=blue&style=flat-square)](https://discord.com/invite/zT4AMStAJA)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg?style=flat-square)](https://pub.dev/packages/very_good_analysis)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?style=flat-square)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?label=test&style=flat-square)


# Introduction 

This package contains annotations for [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) with which the generator will create the widgetbook defined in [package:widgetbook](https://pub.dev/packages/widgetbook). Therefore, this package is a part of making [package:widgetbook](https://pub.dev/packages/widgetbook) easier to maintain. Furthermore, setting up [package:widgetbook](https://pub.dev/packages/widgetbook) is simplified by code generation. 

# Installing this package

Add [package:widgetbook_annotation](https://pub.dev/packages/widgetbook_annotation) as a production dependency to your pubspec file. 

Furthermore, add the following packages as develoment dependencies:

- [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator)
- [package:build_runner](https://pub.dev/packages/build_runner)

For documentation on how to setup and use the packages mentioned above, see their corresponding [pub.dev](https://pub.dev/) pages.

# Avaialble annotations

This package features the annotations `WidgetbookApp`, `WidgetbookStory`, and `WidgetbookTheme`. The annotations and their usage are explained below.

## WidgetbookApp

The annotation `WidgetbookApp` defines two things and can be added to any code element. However, the location of the file in which `WidgetbookApp` is used defines the folder in which [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) will create the file in which the Widgetbook is created. 

### Parameters

The annotation `WidgetbookApp` has one required parameter `name` and one optional parameter `devices` 

From the `name` parameter, the generator will create the `AppInfo` property of [package:widgetbook](https://pub.dev/packages/widgetbook). Therefore, this value will show in the upper left corner of the Widgetbook. 

From the `devices` parameter, the generator will create the devices in which one can preview the widgets. 

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

one might add `WidgetbookApp` to the `App` Widget defined in app.dart

```dart 
@WidgetbookApp('Example App')
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
```

[package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) will then create a new file `app.widgetbook.dart` next to the `app.dart` file. the resulting app structure will look like this:

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

## WidgetbookStory

`WidgetbookStory` allows developers to mark functions as a story. The `WidgetbookStory` expect a story of the format 

```dart
Widget name(BuildContext context) {  
  ...
}
```

### Parameters

`WidgetbookStory` requires the two parameters `name` and `type`. 

The `name` parameter specifies how the story will be displayed in the Widgetbook.

The `type` parameter specifies to which type of Widget the Story belongs. From this information and the location of the file in which the annotation is used, [package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) will create the Organizer elements shown on the left side of the Widgetbook.

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

A story for AwesomeTile located in `/lib/tiles/awesome_tile.dart` can be defined in that exact file by implementing the following

```dart 
@WidgetbookStory(name: 'Default', type: AwesomeTile)
Widget awesomeTileStory(BuildContext context) {
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

It often happens that your widget is more complex. In such a case feel free to wrap the widget with whatever you need. This can also be a Provider, Bloc or other state management Widget. 

After generating the code for the Widgetbook you will find a navigation panel with the following content.

```
stories (Category)
├─ tiles (Folder)
│  ├─ AwesomeTile (WidgetElement)
│  │  ├─ Default (Story)
```

If you require multiple stories for a Widget feel free to define multiple `WidgetbookStory`s per Widget. The additional Stories will be located in the navigation panel similar to the showcased Story. 

## WidgetbookTheme

`WidgetbookTheme` allows developers to annotate the light and dark theme of their app. Similar to `WidgetbookStory`, `WidgetbookTheme` is used on methods returning a `ThemeData` object. 

### Constructors

`WidgetbookTheme` features two constructors `WidgetbookTheme.light()` and `WidgetbookTheme.dark()` for differentiation between the light and dark theme of the app. 

### Example

```dart
@WidgetbookTheme.dark()
ThemeData getDarkTheme() => ThemeData(
      primarySwatch: Colors.blue,
    );
```