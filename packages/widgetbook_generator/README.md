<img height=40 src="https://raw.githubusercontent.com/widgetbook/widgetbook/2107e1afe2217e8ecde56c6ade1fd3706c3e6570/docs/assets/WidgetbookLogo.svg">

[![Discord](https://img.shields.io/discord/879618555560218625?color=blue&style=flat-square)](https://discord.com/invite/zT4AMStAJA)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg?style=flat-square)](https://pub.dev/packages/very_good_analysis) 
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?style=flat-square)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?label=test&style=flat-square)
[![youtube: How to](https://img.shields.io/badge/YouTube-What%20is%20Widgetbook%3F-d05454?style=flat-square)](https://www.youtube.com/watch?v=vs3ocjMsl7s)
[![youtube: How to](https://img.shields.io/badge/YouTube-How%20to%20%20use%20Widgetbook%3F-d05454?style=flat-square)](https://www.youtube.com/watch?v=qcTZxJDLEAE) 
[![youtube: How to](https://img.shields.io/badge/YouTube-How%20to%20%20use%20Widgetbook%20Generator%3F-d05454?style=flat-square)](https://www.youtube.com/watch?v=dh8hxgtbjtk) 

[package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) allows to generate and setup code for [package:widgetbook](https://pub.dev/packages/widgetbook) which simplifies using and maintaining Widgetbook.

## Before you start

Before you start with this package, we recommend to read the documentation of [package:widgetbook](https://pub.dev/packages/widgetbook) or watch the videos [What is Widgetbook](https://www.youtube.com/watch?v=vs3ocjMsl7s) and [How to use Widgetbook](https://www.youtube.com/watch?v=qcTZxJDLEAE).

# Packages 

This package requires the following dependency: 

| Package           | Pub |
| ----------------- | --------------------------------- |
| [package:widgetbook_annotation](https://pub.dev/packages/widgetbook_annotation) | [![Pub Version](https://img.shields.io/pub/v/widgetbook_annotation?style=flat-square)](https://pub.dev/packages/widgetbook_annotation) |

and the following dev dependencies:

| Package           | Pub |
| ----------------- | --------------------------------- |
| [package:widgetbook](https://pub.dev/packages/widgetbook) | [![Pub Version](https://img.shields.io/pub/v/widgetbook?style=flat-square)](https://pub.dev/packages/widgetbook) |
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

# Annotations

The generator works with the annotations documented at [package:widgetbook_annotation](https://pub.dev/packages/widgetbook_annotation). 

# Run the generator

The generator defined in this package uses [package:build_runner](https://pub.dev/packages/build_runner) to generate the desired code.

You can execute the generator by running `flutter pub run build_runner build`. 

If you are making a lot of changes while developing, you can also run `flutter pub run build_runner watch` so [package:build_runner](https://pub.dev/packages/build_runner) will listen for changes in the file system and update Widgetbook accordingly.

# Start the generated app

The generator will create the `app.widgetbook.dart` file in the same directory as the file in which `@WidgetbookApp` is used. For details about this, see the documentation of [package:widgetbook_annotation](https://pub.dev/packages/widgetbook_annotation).

Start the app by running `flutter run lib/app.widgetbook.dart`.

# Hot reloading

Hot reloading of changes in Widgetbook works out of the box. For limitations see [package:widgetbook](https://pub.dev/packages/widgetbook).

# Let us know how you feel about Widgetbook

We are funded and aim to shape `Widgetbook` to your (and your team's) needs. If you have questions, feature requests or issues let us know on [Discord](https://discord.gg/zT4AMStAJA) or [GitHub](https://github.com/widgetbook/widgetbook). We're looking forward to build a community and discuss your feedback on our channel! 💙
