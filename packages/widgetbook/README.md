<p align="center">
<a href="https://discord.gg/773cqza4x5"><img src="https://img.shields.io/discord/879618555560218625?color=blue&logo=discord&style=flat-square" alt="Discord"></a>
<a href="https://pub.dev/packages/flutter_lints"><img src="https://img.shields.io/badge/style-flutter%20lints-40c4ff?style=flat-square" alt="build"></a>
<a href="https://github.com/firecrownpro/widgetbook/actions"><img src="https://img.shields.io/github/workflow/status/firecrownpro/widgetbook/ci?style=flat-square" alt="build"></a>

</p>

___

A flutter package that helps cataloguing widgets. Inspired by Storybook.js and flutterbook.

<p align="center">
<img src="https://media.githubusercontent.com/media/widgetbook/widgetbook/main/docs/assets/Screenshot.png" alt="Widgetbook Screenshot" />
</p>

## See it in action!

Check out the `Widgetbook` with the example app on our [github page](https://firecrownpro.github.io).
Furthermore, you can [check out the code of the app at github](https://github.com/firecrownpro/widgetbook/tree/main/example). 

## Let us know how you feel about Widgetbook

We are funded and aim to shape `Widgetbook` to your (and your team's) needs. If you have questions, feature requests or issues let us know on [Discord](https://discord.gg/zT4AMStAJA) or [GitHub](https://github.com/firecrownpro/widgetbook) or book a call with the founders via [Calendly](https://calendly.com/firecrown/call). We're looking forward to build a community and discuss your feedback on our channel! 💙

## Getting Started

This package provides a flutter widget called `Widgetbook` in which custom widgets from your app can be injected.

### Enabling Hot Reload

Wrap the `Widgetbook` into a stateless widget to enable hot reloading whenever changes are made to the `Widgetbook`'s parameters. 
```dart
class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(...);
  }
}
```

### Running the Widgetbook

To run the `Widgetbook` create a new main method, e.g. in `stories/main.dart`:

```dart
void main() {
  runApp(HotReload());
}
```

Run the `Widgetbook` main method by executing `flutter run -t stories/main.dart`.

### Inject your widgets

Your widgets can be organized into different areas of interest by using `Category`, `Folder`, `WidgetElement` and `Story`.

```dart
class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      categories: [
        Category(
          name: 'widgets',
          widgets: [
            WidgetElement(
              name: '$CustomWidget',
              stories: [
                Story(
                  name: 'Default',
                  builder: (context) => CustomWidget(),
                ),
              ],
            ),
          ],
          folders: [
            Folder(
              name: 'Texts',
              widgets: [
                WidgetElement(
                  name: 'Normal Text',
                  stories: [
                    Story(
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

## Set storybook name

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

### Define own device

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

- Hot reloading on web is currently not working properly. This is due to the fact that hot reloading is actually a restart. The problem is tracked in [widgetbook/issues/4](https://github.com/firecrownpro/widgetbook/issues/4). For now we recommended to use MacOS or Windows as a platform for development.