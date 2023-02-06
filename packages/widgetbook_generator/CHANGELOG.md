## 3.0.0-beta.8

 - **REFACTOR**: :recycle: warnings. ([8bf0b124](https://github.com/widgetbook/widgetbook/commit/8bf0b12447bf05ac35879000d5ff64ce27244290))
 - **REFACTOR**: :recycle: settings. ([254ebef6](https://github.com/widgetbook/widgetbook/commit/254ebef6fe38b2d8f3fc847366f4725ab9292ccb))
 - **REFACTOR**: :recycle: adjust generator to `AddOn` implemementation. ([a91edbbf](https://github.com/widgetbook/widgetbook/commit/a91edbbf91500329bda9eb3882861b84527b9c4a))
 - **REFACTOR**: :recycle: rename `settings` to `setting` for `AddOn`s. ([c88b7327](https://github.com/widgetbook/widgetbook/commit/c88b7327ace63cb2d2fd4b4dc8f699611f6a4998))
 - **REFACTOR**: :recycle: remove resolvers. ([59565b2a](https://github.com/widgetbook/widgetbook/commit/59565b2a2b49803dff8f3d5824c39c35a68eeeac))
 - **REFACTOR**: adjusted code to match linter. ([04dd9f1e](https://github.com/widgetbook/widgetbook/commit/04dd9f1e6678e9d9531cb70c777281c4d050aa61))
 - **FIX**: :bug: locales are not correctly generated. ([dd2807d0](https://github.com/widgetbook/widgetbook/commit/dd2807d0f34f1c4dc0d084e5e07d08d8c8c1f95c))
 - **FIX**: imports of file not deterministic. ([2ffb120d](https://github.com/widgetbook/widgetbook/commit/2ffb120ddbb269d7a63494acfeb6adb009a1f6d3))
 - **FIX**: custom painter Widgets are incorrectly rendered. ([965c355e](https://github.com/widgetbook/widgetbook/commit/965c355e03cd7e9c9d62c473f1d29a006c07626e))
 - **FIX**: recommited binary files to git. ([70f38e8f](https://github.com/widgetbook/widgetbook/commit/70f38e8f2427dfd55c6573f357099eb41dbdee63))
 - **FIX**: added error when WidgetbookTheme is used on non-function code elements. ([b7e65c24](https://github.com/widgetbook/widgetbook/commit/b7e65c24a7f61ebe0e7e5f498c9c64de8bfea45b))
 - **FEAT**: :sparkles: add design link property. ([7aa22dca](https://github.com/widgetbook/widgetbook/commit/7aa22dcab851ab0ca42a1902b8e6c08c2caae195))
 - **FEAT**: :sparkles: add CustomThemeAddon to generator. ([ed199af2](https://github.com/widgetbook/widgetbook/commit/ed199af20c0644cce762dc2d002b1e9b6e2f0a89))
 - **FEAT**: :sparkles: add FrameAddon to generator. ([c77fddeb](https://github.com/widgetbook/widgetbook/commit/c77fddeb09567cea874185ed6ffed0f5e408d0c2))
 - **FEAT**: :sparkles: add LocalizationAddon to generator. ([0df318ec](https://github.com/widgetbook/widgetbook/commit/0df318ecae3e8737aabc7c94a70011d162fade33))
 - **FEAT**: :sparkles: add TextScaleThemeAddon to generator. ([563d6697](https://github.com/widgetbook/widgetbook/commit/563d6697cc5e354e6adc3a72a3b7d6b905f67ac0))
 - **FEAT**: :sparkles: add MaterialThemeAddon to generator. ([ba1b8f82](https://github.com/widgetbook/widgetbook/commit/ba1b8f82ec7ed86fd4fcc9a6181c4ab9a82b9a4e))
 - **FEAT**: generator reads use-case definition. ([84298485](https://github.com/widgetbook/widgetbook/commit/84298485ce2d9ec35fec68188dc91a52e5ab7764))

## 3.0.0-beta.7

- refactor: generator creating `use case` category as topmost `NavigationTree` element

## 3.0.0-beta.6

- refactor: adjusted generator to the new `NavigationTree`

## 3.0.0-beta.5

- refactor: adjusted generator to follow the new structure

## 3.0.0-beta.4

- chore: bumped `widgetbook_models` version

## 3.0.0-beta.3

- fix: locales are not correctly generated 

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
