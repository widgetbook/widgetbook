## 3.0.0-beta.4

 - **REFACTOR**: :recycle: settings. ([254ebef6](https://github.com/widgetbook/widgetbook/commit/254ebef6fe38b2d8f3fc847366f4725ab9292ccb))
 - **REFACTOR**: :recycle: remove obsolete annotations. ([c6dd4f54](https://github.com/widgetbook/widgetbook/commit/c6dd4f54a11a8c2e9cd01d2429a866d7a14510ab))
 - **REFACTOR**: adjusted code to match linter. ([04dd9f1e](https://github.com/widgetbook/widgetbook/commit/04dd9f1e6678e9d9531cb70c777281c4d050aa61))
 - **FIX**: :test_tube: fixed broken test. ([6e56b79a](https://github.com/widgetbook/widgetbook/commit/6e56b79aada01a782d04f846c5ce2f126c98a575))
 - **FIX**: custom painter Widgets are incorrectly rendered. ([965c355e](https://github.com/widgetbook/widgetbook/commit/965c355e03cd7e9c9d62c473f1d29a006c07626e))
 - **FIX**: recommited binary files to git. ([70f38e8f](https://github.com/widgetbook/widgetbook/commit/70f38e8f2427dfd55c6573f357099eb41dbdee63))
 - **FIX**: example for locales does not compile. ([db880e76](https://github.com/widgetbook/widgetbook/commit/db880e76569d6162f473ea8c3791786325fe0140))
 - **FIX**: replaced WidgetbookTheme.dark() with the proper WidgetbookTheme annotation. ([49a6cd79](https://github.com/widgetbook/widgetbook/commit/49a6cd79b84b337a2ddef18f3f6041618d3d7e7c))
 - **FIX**: removed themeType as a property of material and cupertino constructors. ([4f9f488a](https://github.com/widgetbook/widgetbook/commit/4f9f488ab961ec85298ede8da058b187c2afdd94))

## 3.0.0-beta.3

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
