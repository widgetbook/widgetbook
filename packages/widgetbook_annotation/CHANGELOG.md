## 3.0.0-beta.2

- chore: bumped `widgetbook_models` version

## 3.0.0-beta.1

- **BREAKING**: refactor: removed `WidgetbookUseCaseBuilder`, `WidgetbookDeviceFrameBuilder`, `WidgetbookLocalizationBuilder`, `WidgetbookScaffoldBuilder`, `WidgetbookThemeBuilder` annotations because [widgetbook](https://pub.dev/packages/widgetbook) does not longer support the builders.
- feat: add `designLink` property to `WidgetbookUseCase` annotation.

## 2.1.0 
- fix: Custom painter Widgets are incorrectly rendered ([#191](https://github.com/widgetbook/widgetbook/issues/191))
    - added `WidgetbookAppBuilder` annotation.

## 2.0.3

- chore: updated docs to link to [docs.widgetbook.io](https://docs.widgetbook.io)

## 2.0.2

- fix: use `widgetbook_models` in version `v0.0.7`

## 2.0.1

- refactor: renamed `WidgetbookWidget` to `WidgetbookComponent`
- fix: Missing error when `@WidgetbookTheme` is used on properties ([#130](https://github.com/widgetbook/widgetbook/issues/130))
- fix: `@WidgetbookApp` wrongly exposes `ThemeType` property ([#129](https://github.com/widgetbook/widgetbook/issues/129))

## 2.0.0

- feat: added annotations to support [widgetbook](https://pub.dev/packages/widgetbook) in version 2.0.x

## 1.0.1 

- added documentation for skipping of the `src` folder
- added the option to specify a default theme. Defaults to `ThemeMode.system`

## 1.0.0

- changed `WidgetbookStory` to `WidgetbookUseCase`

## 0.0.4

- bumped version of `widgetbook_models` to `0.0.3`

## 0.0.3

- updated readme

## 0.0.2

- added export of [package:widgetbook_models](https://pub.dev/packages/widgetbook_models) to make usage more convenient. 

## 0.0.1

Released first beta
