## 3.9.0

- **BREAKING**: Set minimum SDK version to 3.8.0. ([#1719](https://github.com/widgetbook/widgetbook/pull/1719))

## 3.8.0

- **FEAT**: Allow excluding use-cases with `@UseCase.exclude`. ([#1676](https://github.com/widgetbook/widgetbook/pull/1676) - by [@EArminjon](https://github.com/EArminjon))
- **FEAT**: Add `IterableKnobConfig` to support the new `iterable` knob. ([#1678](https://github.com/widgetbook/widgetbook/pull/1678) - by [@EArminjon](https://github.com/EArminjon))

## 3.7.0

- **BREAKING**: Set minimum SDK version to 3.7.0. ([#1541](https://github.com/widgetbook/widgetbook/pull/1541))
- **FEAT**: Add `ObjectKnobConfig` to support the new `knobs.object` variants. ([#1478](https://github.com/widgetbook/widgetbook/pull/1478) - by [@Sourav-Sonkar](https://github.com/Sourav-Sonkar))
- **REFACTOR**: Deprecate `ListKnobConfig` in favor of `ObjectKnobConfig`. ([#1547](https://github.com/widgetbook/widgetbook/pull/1547))

## 3.6.0

- **FEAT**: Add `@UseCase.cloudExclude` option to exclude use-cases from Widgetbook Cloud. ([#1535](https://github.com/widgetbook/widgetbook/pull/1535))
- **CHORE**: Update license. ([#1529](https://github.com/widgetbook/widgetbook/pull/1529))

## 3.5.0

- **FEAT**: Add `NullKnobConfig` to support null values in `KnobConfig`s. ([#1451](https://github.com/widgetbook/widgetbook/pull/1451))

## 3.4.0

- **FEAT**: Add `SemanticsAddonConfig` for supporting the new **experimental** [`SemanticsAddon`](https://docs.widgetbook.io/addons/semantics-addon). ([#1402](https://github.com/widgetbook/widgetbook/pull/1402))
- **FEAT**: Support Multi Snapshot for knobs. For more information, check our [docs](https://docs.widgetbook.io/cloud/snapshots/multi-snapshot#multi-snapshot-for-knobs). ([#1394](https://github.com/widgetbook/widgetbook/pull/1394))

## 3.3.1

- **REFACTOR**: Add generic parameter to `AddonConfig`; to allow supporting non-primitive addon configs (e.g. `ViewportAddonConfig`). ([#1318](https://github.com/widgetbook/widgetbook/pull/1318))

## 3.3.0

- **BREAKING**: Set minimum SDK version to 3.3.0. ([#1349](https://github.com/widgetbook/widgetbook/pull/1349))

## 3.2.0

- **BREAKING**: Set minimum SDK version to 3.0.0. ([#1243](https://github.com/widgetbook/widgetbook/pull/1243))
- **FEAT**: Support Multi Snapshot for addons. For more information, check our [docs](https://docs.widgetbook.io/cloud/snapshots/multi-snapshot). ([#1239](https://github.com/widgetbook/widgetbook/pull/1239))

## 3.1.0

- **BREAKING**: Set minimum SDK version to 2.19.0. ([#1030](https://github.com/widgetbook/widgetbook/pull/1030))
- **FEAT** Add `path` property on `@UseCase` to specify a custom path to be used instead of the component's location. ([#988](https://github.com/widgetbook/widgetbook/pull/988) - by [@geisterfurz007](https://github.com/geisterfurz007))

## 3.0.0

Check out the [migration guide](https://docs.widgetbook.io/migration/2.4.0-to-3.0.0) for more information.

## 3.0.0-rc.2

- **BREAKING**: Remove `@App` annotation's `foldersExpanded` and `widgetsExpanded` non-working parameters. ([#735](https://github.com/widgetbook/widgetbook/pull/735))

## 3.0.0-rc.1

- Check out the [migration guide](https://docs.widgetbook.io/~docs%2Fwidgetbook-3/migration/3.0.0-beta-to-rc) for more details.
- **FEAT**: Add Dart 3 and Flutter 3.10 support. ([#676](https://github.com/widgetbook/widgetbook/pull/676))
- **BREAKING**: Drop Flutter 2 support. ([#676](https://github.com/widgetbook/widgetbook/pull/676))
- **BREAKING**: Remove `Widgetbook` prefix from all annotation names. ([#649](https://github.com/widgetbook/widgetbook/pull/649))
- **BREAKING**: Remove code generation support for everything except `@App` and `@UseCase` that generate a list called `directories`. You should now configure Widgetbook's properties (i.e. `addons`, `appBuilder`, etc.) manually. ([#663](https://github.com/widgetbook/widgetbook/pull/663))

## 3.0.0-beta.7

- **REFACTOR**: :recycle: removed package analysis_options files.
- **REFACTOR**: :recycle: warnings.

## 3.0.0-beta.6

- **FIX**: :bug: remove obsolete `name` property. ([0e681371](https://github.com/widgetbook/widgetbook/commit/0e68137119af6a73e8f182ff833421f196589283))

## 3.0.0-beta.5

- **REFACTOR**: :recycle: settings. ([254ebef6](https://github.com/widgetbook/widgetbook/commit/254ebef6fe38b2d8f3fc847366f4725ab9292ccb))
- **REFACTOR**: :recycle: remove obsolete annotations. ([c6dd4f54](https://github.com/widgetbook/widgetbook/commit/c6dd4f54a11a8c2e9cd01d2429a866d7a14510ab))
- **REFACTOR**: adjusted code to match linter. ([04dd9f1e](https://github.com/widgetbook/widgetbook/commit/04dd9f1e6678e9d9531cb70c777281c4d050aa61))
- **FIX**: :test_tube: fixed broken test. ([6e56b79a](https://github.com/widgetbook/widgetbook/commit/6e56b79aada01a782d04f846c5ce2f126c98a575))
- **FIX**: custom painter Widgets are incorrectly rendered. ([965c355e](https://github.com/widgetbook/widgetbook/commit/965c355e03cd7e9c9d62c473f1d29a006c07626e))
- **FIX**: recommited binary files to git. ([70f38e8f](https://github.com/widgetbook/widgetbook/commit/70f38e8f2427dfd55c6573f357099eb41dbdee63))
- **FIX**: example for locales does not compile. ([db880e76](https://github.com/widgetbook/widgetbook/commit/db880e76569d6162f473ea8c3791786325fe0140))
- **FIX**: replaced WidgetbookTheme.dark() with the proper WidgetbookTheme annotation. ([49a6cd79](https://github.com/widgetbook/widgetbook/commit/49a6cd79b84b337a2ddef18f3f6041618d3d7e7c))
- **FIX**: removed themeType as a property of material and cupertino constructors. ([4f9f488a](https://github.com/widgetbook/widgetbook/commit/4f9f488ab961ec85298ede8da058b187c2afdd94))

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
