## 2.2.1

- fix: use `widgetbook_models` in version `v0.0.7`

## 2.2.0

- chore: bumped `freezed` and `freezed_annotation` to `v2.0.3` ([#174](https://github.com/widgetbook/widgetbook/issues/174))

## 2.1.2

- fix: `useCaseBuilder` is called with old context ([#180](https://github.com/widgetbook/widgetbook/issues/180))

## 2.1.1

- fix: knob values do not update when usecase changes ([#170](https://github.com/widgetbook/widgetbook/issues/170))

## 2.1.0

- feature: added knobs to dynamically change parameters of a usecase ([#21](https://github.com/widgetbook/widgetbook/issues/21))

## 2.0.9

- fix: orientation defaults to landscape ([#161](https://github.com/widgetbook/widgetbook/issues/161))

## 2.0.8

- fix: navigation tree collapsing and expanding does not work ([#159](https://github.com/widgetbook/widgetbook/issues/159))

## 2.0.7

- fix: expanding of elements within the navigation is not working ([#156](https://github.com/widgetbook/widgetbook/issues/156))

## 2.0.6

- refactor: renamed `WidgetbookWidget` to `WidgetbookComponent`
- fix: `ScaffoldMessenger` opens in `Widgetbook` and not in the previewed app ([#148](https://github.com/widgetbook/widgetbook/issues/148))
- fix: Missing error when `@WidgetbookTheme` is used on properties ([#130](https://github.com/widgetbook/widgetbook/issues/130))
- fix: `@WidgetbookApp` wrongly exposes `ThemeType` property ([#129](https://github.com/widgetbook/widgetbook/issues/129))
- closed: Widgetbook cannt be run for flutter version below 2.10 ([#113](https://github.com/widgetbook/widgetbook/issues/113))
- fix: setState called during build ([#92](https://github.com/widgetbook/widgetbook/issues/92))
- closed: Scrolling interferes with zooming ([#85](https://github.com/widgetbook/widgetbook/issues/85))

## 2.0.5

- feat: added `textScaleFactors` for font accessibility ([#15](https://github.com/widgetbook/widgetbook/issues/15))
- fix: added `MediaQuery` to `WidgetbookDeviceFrame` ([#66](https://github.com/widgetbook/widgetbook/issues/66))
- feat: added [device_frame](https://pub.dev/packages/device_frame) ([#112](https://github.com/widgetbook/widgetbook/pull/114))

## 2.0.3

- fix: UI not optimized for light theme [#110](https://github.com/widgetbook/widgetbook/issues/110)

## 2.0.2

- fix: pan cannot be reset in viewport [#99](https://github.com/widgetbook/widgetbook/issues/99)
- fix: use cases cannot be previewed without a device [#84](https://github.com/widgetbook/widgetbook/issues/84)
- fix: cannot inject custom themes into widget tree [#75](https://github.com/widgetbook/widgetbook/issues/75)
- fix: cannot wrap use cases in other widgets [#74](https://github.com/widgetbook/widgetbook/issues/74)
- fix: cannot set a default theme [#60](https://github.com/widgetbook/widgetbook/issues/60)
- fix: cannot show multiple devices next to each other [#55](https://github.com/widgetbook/widgetbook/issues/55)
- fix: no way to use widgets that require localization [#53](https://github.com/widgetbook/widgetbook/issues/53)
- fix: device can be moved out of sight [#7](https://github.com/widgetbook/widgetbook/issues/7)
- fix: viewport resets when different story is selected [#6](https://github.com/widgetbook/widgetbook/issues/6)  

## 1.0.3

- changed documentation to be consistent with the existing videos
- changed theme to default to `ThemeMode.system` instead of `ThemeMode.dark`
- fixed `Tile`s overflowing on long names

## 1.0.2

- added videos to documentation

## 1.0.1

- renamed property `stories` of `WidgetbookWidget` to `useCases`

## 1.0.0

renamed organizer elements to make them less generic. Renamed to the following:

- `Category` renamed to `WidgetbookCategory`
- `Folder` renamed to `WidgetbookFolder`
- `WidgetElement` renamed to `WidgetbookWidget`
- `Story` renamed to `WidgetbookUseCase`

## 0.0.16

- fixed error thrown when switching to a theme that is not defined
- added a widget indicating that the current theme is not defined

## 0.0.15

- fixed brightness not being inherited to the rendered `Story`

## 0.0.14

- bumped version of `widgetbook_models` to `0.0.3`

## 0.0.13

- updated readme

## 0.0.12

- added dependency to [package:widgetbook_models](https://pub.dev/packages/widgetbook_models) which defines the `Device` class.

## 0.0.11

- added a search bar to filter for widgets and folders

## 0.0.10

- removed `bloc` and `flutter_bloc` dependency
- removed `url_launcher` dependency

## 0.0.9

Increased package compatibility by

- replacing [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) package with Material icons
- removing [google_fonts](https://pub.dev/packages/google_fonts) package
- removing [recase](https://pub.dev/packages/recase) package

## 0.0.8

- added CI/CD badge

## 0.0.7

- removed example app from package

## 0.0.6

- fixed navigation not working for web

## 0.0.5

- fixed navigation tree elements collapsing on hot reloads

## 0.0.4

- added known issue to documentation

## 0.0.3 

- fixed hot reloading not working for the selected story
- fixed ControlBar overflow
- removed unused package from pubspec

## 0.0.2

- Added docs to public API

## 0.0.1

- Initial release