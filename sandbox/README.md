# Sandbox

Widgetbook's own "Widgetbook" (i.e. a catalog for widgets built inside `widgetbook` package).

## Getting started

1. Install [melos](https://melos.invertase.dev/getting-started)
1. Bootstrap the project

    ```bash
    melos bootstrap
    ```

1. Generate files

    ```bash
    melos generate
    ```

1. Run the project

    ```bash
    flutter run lib/widgetbook.dart
    ```

    On a screen narrower than 840 logical pixels, Widgetbook renders the
    `MobileLayout`, which shows the navigation, addons and knobs panels in a
    bottom sheet. To exercise that layout on iOS:

    ```bash
    flutter run -d <ios-device-or-simulator> lib/widgetbook.dart
    ```
