<img height=40 src="https://raw.githubusercontent.com/widgetbook/widgetbook/4130a18efa61a1b94185409a6f7a735e0494fb30/docs/assets/WidgetbookLogo.svg">

[![Discord](https://img.shields.io/discord/879618555560218625?color=blue&style=flat-square)](https://discord.com/invite/zT4AMStAJA)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg?style=flat-square)](https://pub.dev/packages/very_good_analysis) 
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?style=flat-square)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/widgetbook/widgetbook/ci?label=test&style=flat-square)

[package:widgetbook_generator](https://pub.dev/packages/widgetbook_generator) allows to generate and setup code for [package:widgetbook](https://pub.dev/packages/widgetbook) which simplifies using and maintaining Widgetbook.

## Before you start

We recommend reading the documentation of [package:widgetbook](https://pub.dev/packages/widgetbook) before you start with this package. 

# Packages 

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
  widgetbook:
  widgetbook_annotation:

dev_dependencies:
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

We are funded and aim to shape `Widgetbook` to your (and your team's) needs. If you have questions, feature requests or issues let us know on [Discord](https://discord.gg/zT4AMStAJA) or [GitHub](https://github.com/widgetbook/widgetbook) or book a call with the founders via [Calendly](https://calendly.com/widgetbook/call). We're looking forward to build a community and discuss your feedback on our channel! 💙