# widgetbook_starter

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to simplify the setup of Widgetbook for Flutter Apps.
For setup within a mono-repo use the [widgetbook_app](https://brickhub.dev/bricks/widgetbook_app/) brick.

## How to use 🚀

```bash
mason make widgetbook_starter --name "Name of your app"
```

## Variables ✨

| Variable | Type       | Description            |
| -------- | ---------- | ---------------------- |
| `name`   | `string`   | The name of the Widgetbook. Used to generate [`AppInfo`](https://docs.widgetbook.io/widgetbook/properties#appinfo). |

## Outputs 📦

```bash
mason make widgetbook_starter --name "Name of your app"
└── widgetbook
    ├── main.dart
    └── widgetbook.dart 
```

__main.dart__

```dart
import 'package:flutter/material.dart';

import 'widgetbook.dart';

void main(List<String> args) {
  runApp(const WidgetbookHotReload());
}
```

__widgetbook.dart__
```dart
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class WidgetbookHotReload extends StatelessWidget {
  const WidgetbookHotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      categories: [
        WidgetbookCategory(
          name: 'material',
          widgets: [
            WidgetbookComponent(
              name: 'FAB',
              useCases: [
                WidgetbookUseCase(
                  name: 'Icon',
                  builder: (context) {
                    return FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.add),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      appInfo: AppInfo(name: '{{name}}'),
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
    );
  }
}
```