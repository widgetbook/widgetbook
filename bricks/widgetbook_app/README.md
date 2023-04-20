# widgetbook_app

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to simplify the setup of a Widgetbook Flutter app when working with packages and mono-repos.

## How to use 🚀

```bash
mason make widgetbook_starter --name "Awesome" --package "awesome_package"
```

## Variables ✨

| Variable  | Type       | Description            |
| --------- | ---------- | ---------------------- |
| `name`    | `string`   | The name of the Widgetbook. Used to generate [`AppInfo`](https://docs.widgetbook.io/widgetbook/properties#appinfo). |
| `package` | `string`   | The name of the package containing the components. Used to include the package in the generated `pubspec.yaml`. |

## Assumed structure 🏗

The brick assumes the following mono-repo structure:

mono-repo
├── docs
├── examples
├── packages
│   ├── awesome_package
│   └── package_2
└── other_folder

## Outputs 📦

```bash
mason make widgetbook_starter --name "Awesome" --package "awesome_package"
└── mono-repo
    ├── docs
    ├── examples
    ├── packages
    │   ├── awesome_package
    │   └── package_2
    ├── other_folder
    └── widgetbooks
        └── awesome_package_widgetbook
            ├── lib
            │   ├── ui_catalogs.dart
            │   ├── ui_catalogs.widgetbook.dart 
            │   └── components.dart
            ├── macos
            ├── web
            ├── windows
            ├── pubspec.yaml
            └── README.md
```

__app.dart__

```dart
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookTheme(name: 'Light')
ThemeData lightTheme() {
  return ThemeData.light();
}

@WidgetbookTheme(name: 'Dark')
ThemeData darkTheme() {
  return ThemeData.dark();
}

@WidgetbookApp.material(
  name: '{{package.pascalCase()}}',
)
int? notUsed;
```

__components.dart__

```dart
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookUseCase(name: 'Default', type: FloatingActionButton)
Widget buildFab(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  );
}
```
