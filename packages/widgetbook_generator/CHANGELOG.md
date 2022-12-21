## 3.0.0-beta.2

- chore: bumped `widgetbook_models` version

## 3.0.0-beta.1

- **BREAKING**: refactor: remove `DeviceFrameBuilderResolver`, `LocalizationBuilderResolver`, `ScaffoldBuilderResolver`, `ThemeBuilderResolver`, `UseCaseBuilderResolver`.
- feat: add `MaterialThemeAddon` to generator
- feat: add `TextScaleAddon` to generator
- feat: add `LocalizationAddon` to generator
- feat: add `FrameAddon` to generator
- feat: add `CustomThemeAddon` to generator
- feat: add `designLink` property to resolver


## 2.4.1

- fix: imports of generated file not deterministic ([#167](https://github.com/widgetbook/widgetbook/issues/167))

## 2.4.0

- feat: added builders to generate `.json` files for annotated code elements.

## 2.2.0

- fix: Custom painter Widgets are incorrectly rendered ([#191](https://github.com/widgetbook/widgetbook/issues/191))
    - added support for `WidgetbookAppBuilder` and the `appBuilder` property.

## 2.1.2

- chore: updated docs to link to [docs.widgetbook.io](https://docs.widgetbook.io)

## 2.1.1

- fix: use `widgetbook_models` in version `v0.0.7`

## 2.1.0

- chore: bumped `freezed` and `freezed_annotation` to `v2.0.3` ([#174](https://github.com/widgetbook/widgetbook/issues/174))

## 2.0.1

- refactor: renamed `WidgetbookWidget` to `WidgetbookComponent`
- fix: Missing error when `@WidgetbookTheme` is used on properties ([#130](https://github.com/widgetbook/widgetbook/issues/130))

## 2.0.0

- feat: adapted generator for [widgetbook](https://pub.dev/packages/widgetbook) 2.0.x ([#115](https://github.com/widgetbook/widgetbook/issues/115))

## 1.0.3

- changed documentation to be consistent with the existing videos
- changed generator to skip the `src` folder for packages
- changed theme to default to `ThemeMode.system` instead of `ThemeMode.dark`

## 1.0.2

- added videos to documentation

## 1.0.1

- adjusted to renamed properties of `widgetbook` package
- bumped `widgetbook_annotation` version

## 1.0.0

- changed generator to create code for Widgetbook 1.0.0

## 0.0.6

- refactored code
- added tests

## 0.0.5

- bumped version of `widgetbook_annotation` to `0.0.4`

## 0.0.4

- bumped version of `widgetbook_models` to `0.0.3`

## 0.0.3

- updated readme

## 0.0.2 

- fixed bug in the generator leading to invalid `.dart` file generation

## 0.0.1

Released first beta
