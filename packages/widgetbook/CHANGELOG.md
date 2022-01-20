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