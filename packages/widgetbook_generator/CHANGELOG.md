## 3.20.0

- **BREAKING**: Set minimum SDK version to 3.8.0. ([#1719](https://github.com/widgetbook/widgetbook/pull/1719))

## 3.19.0

- **FEAT**: Support `@UseCase.exclude` to exclude use-cases from the generated Widgetbook. ([#1676](https://github.com/widgetbook/widgetbook/pull/1676) - by [@EArminjon](https://github.com/EArminjon))

## 3.18.0

- **BREAKING**: Remove `next` builders. ([#1634](https://github.com/widgetbook/widgetbook/pull/1634))

## 3.17.0

- **BREAKING**: Require `analyzer` >=8.0.0, `build` >=4.0.0 and `source_gen` >=4.0.0. ([#1584](https://github.com/widgetbook/widgetbook/pull/1584))
- **REFACTOR**: Generate `WidgetbookComponent`, instead of `WidgetbookLeafComponent`, for components with a single use-case. ([#1573](https://github.com/widgetbook/widgetbook/pull/1573))

## 3.16.0

- **REFACTOR**: Allow `analyzer` 8.x. ([#1566](https://github.com/widgetbook/widgetbook/pull/1566))
- **REFACTOR**: Update `source_gen` to 3.1.0; to use `TypeChecker.typeNamed` instead of `TypeChecker.fromRuntime`. ([#1564](https://github.com/widgetbook/widgetbook/pull/1564))

## 3.15.0

- **BREAKING**: Set minimum SDK version to 3.7.0. ([#1541](https://github.com/widgetbook/widgetbook/pull/1541))
- **BREAKING**: Support [new element model API](https://github.com/dart-lang/sdk/blob/main/pkg/analyzer/doc/element_model_migration_guide.md). Use `analyzer` >=7.4.0, `build` >=3.0.0 and `source_gen` >=3.0.0. ([#1544](https://github.com/widgetbook/widgetbook/pull/1544))

## 3.14.0

- **FEAT**: Support `@UseCase.cloudExclude` option. Requires `widgetbook_annotation` >=3.6.0. ([#1535](https://github.com/widgetbook/widgetbook/pull/1535))
- **REFACTOR**: Change generated imports prefixes to use a deterministic format based on the path. ([#1495](https://github.com/widgetbook/widgetbook/pull/1495) - by [@mrgnhnt96](https://github.com/mrgnhnt96))
- **CHORE**: Update license. ([#1529](https://github.com/widgetbook/widgetbook/pull/1529))

## 3.13.0

- **BREAKING**: Use `ViewportData.name` instead of `ViewportData.id`. Requires `widgetbook` >=3.14.0. ([#1454](https://github.com/widgetbook/widgetbook/pull/1454))

## 3.12.0

- **FEAT**: Support Multi Snapshot for knobs. For more information, check our [docs](https://docs.widgetbook.io/cloud/snapshots/multi-snapshot#multi-snapshot-for-knobs). ([#1394](https://github.com/widgetbook/widgetbook/pull/1394))

## 3.11.0

- **FEAT**: Support the **experimental** [`ViewportAddon`](https://docs.widgetbook.io/addons/viewport-addon). ([#1318](https://github.com/widgetbook/widgetbook/pull/1318))

## 3.10.0

- **BREAKING**: Set minimum SDK version to 3.3.0. ([#1349](https://github.com/widgetbook/widgetbook/pull/1349))
- **BREAKING**: Remove `components.book.dart` formatting. If you are using the [SAM architecture](https://docs.widgetbook.io/next/sam), upgrade to `4.0.0-alpha.2` or later versions, instead of using the `experimental_components_builder`. ([#1366](https://github.com/widgetbook/widgetbook/pull/1366))
- **REFACTOR**: Remove direct dependency on [`dart_style`](https://pub.dev/packages/dart_style). ([#1363](https://github.com/widgetbook/widgetbook/pull/1363))
- **REFACTOR**: Allow `analyzer` 7.x. ([#1351](https://github.com/widgetbook/widgetbook/pull/1351))
- **REFACTOR**: Remove unused `useCaseDefinitionPath` and `componentDefinitionPath` from generated use-case metadata. ([#1370](https://github.com/widgetbook/widgetbook/pull/1370))

## 3.9.1

- **FIX**: Escape path resolution if `pubspec.lock` is not found. This bug was affecting running the generator in [Pub Workspaces](https://dart.dev/tools/pub/workspaces). ([#1327](https://github.com/widgetbook/widgetbook/pull/1327))
- **REFACTOR**: Send an owner URL for [telemetry](https://docs.widgetbook.io/telemetry). ([#1324](https://github.com/widgetbook/widgetbook/pull/1324))

## 3.9.0

- **BREAKING**: Set minimum SDK version to 3.0.0. ([#1243](https://github.com/widgetbook/widgetbook/pull/1243))
- **BREAKING**: Drop `analyzer` 5.x support. ([#1243](https://github.com/widgetbook/widgetbook/pull/1243))
- **FEAT**: Support Multi Snapshot for addons. For more information, check our [docs](https://docs.widgetbook.io/cloud/snapshots/multi-snapshot). ([#1239](https://github.com/widgetbook/widgetbook/pull/1239))
- **REFACTOR**: Remove `widgetbook` dependency. ([#1242](https://github.com/widgetbook/widgetbook/pull/1242))

## 3.8.0

- **FEAT**: Add new builder option named `nav_path_mode`, that allows using the navigation path of the use-case instead of the component. For more info, check out the [customization docs](https://docs.widgetbook.io/guides/customization#using-nav_path_mode-option). ([#1188](https://github.com/widgetbook/widgetbook/pull/1188))
- **REFACTOR**: Send a unique project identifier for [telemetry](https://docs.widgetbook.io/telemetry). ([#1189](https://github.com/widgetbook/widgetbook/pull/1189))

## 3.7.0

- **EXPERIMENTAL**: Preserve nullability of generic/function parameters. ([#1092](https://github.com/widgetbook/widgetbook/pull/1092))
- **EXPERIMENTAL**: Allow `key` args. ([#1094](https://github.com/widgetbook/widgetbook/pull/1094))
- **EXPERIMENTAL**: Expose `argsBuilder` for non-custom stories. ([#1095](https://github.com/widgetbook/widgetbook/pull/1095))

## 3.6.0

- **EXPERIMENTAL**: Use params' default values for `StoryArgs.fixed` constructor. ([#1074](https://github.com/widgetbook/widgetbook/pull/1074))
- **EXPERIMENTAL**: Support `EnumArg`. ([#1073](https://github.com/widgetbook/widgetbook/pull/1073))
- **EXPERIMENTAL**: Support `BuilderArg`. ([#1079](https://github.com/widgetbook/widgetbook/pull/1079))
- **EXPERIMENTAL**: Support positional `Arg.value` parameter. ([#1077](https://github.com/widgetbook/widgetbook/pull/1077))
- **EXPERIMENTAL**: Set `Arg.name` via `init` instead of constructor. ([#1078](https://github.com/widgetbook/widgetbook/pull/1078))
- **EXPERIMENTAL**: Support custom args via `MetaWithArgs`. ([#1080](https://github.com/widgetbook/widgetbook/pull/1080))
- **EXPERIMENTAL**: Support `LeafComponent`. ([#1083](https://github.com/widgetbook/widgetbook/pull/1083))
- **EXPERIMENTAL**: Support optional parameters arg-generation. ([#1084](https://github.com/widgetbook/widgetbook/pull/1084))

## 3.5.0

- **EXPERIMENTAL**: Add `setup` to `Story`. ([#1069](https://github.com/widgetbook/widgetbook/pull/1069))

## 3.4.0

- **EXPERIMENTAL**: Add support for [SAM Architecture](https://docs.widgetbook.io/next/sam). ([#1064](https://github.com/widgetbook/widgetbook/pull/1064))

## 3.3.0

- **BREAKING**: Set minimum SDK version to 2.19.0. ([#1030](https://github.com/widgetbook/widgetbook/pull/1030))
- **FEAT**: Add `designLink` to `WidgetbookUseCase`. ([#926](https://github.com/widgetbook/widgetbook/pull/926) - by [@Mastersam07](https://github.com/Mastersam07))
- **FEAT**: Support custom `path` for `@UseCase`. ([#988](https://github.com/widgetbook/widgetbook/pull/988) - by [@geisterfurz007](https://github.com/geisterfurz007))
- **FEAT**: Support `WidgetbookLeafComponent` navigation node for components with a single use-case. ([#1015](https://github.com/widgetbook/widgetbook/pull/1015))

## 3.2.0

- **FEAT**: Add [telemetry](https://docs.widgetbook.io/telemetry) which collects and reports anonymous usage information that helps us improve our package. ([#893](https://github.com/widgetbook/widgetbook/pull/893))
- **FIX**: Sort generated nodes. ([#871](https://github.com/widgetbook/widgetbook/pull/871))
- **FIX**: Apply imports prefixing. ([#872](https://github.com/widgetbook/widgetbook/pull/872))
- **FIX**: Throw error when use-cases names conflict. ([#877](https://github.com/widgetbook/widgetbook/pull/877))

## 3.1.0

- **REFACTOR**: Enforce `widgetbook` package minimum version (v3.2.0). ([#842](https://github.com/widgetbook/widgetbook/pull/842))
- **REFACTOR**: Support `analyzer` v6.x. ([#841](https://github.com/widgetbook/widgetbook/pull/841))
- **FIX**: Add type to `directories` list. ([#836](https://github.com/widgetbook/widgetbook/pull/836))
- **FIX**: Resolve local packages paths. ([#829](https://github.com/widgetbook/widgetbook/pull/829))
- **FIX**: Resolve "asset:" imports. ([#819](https://github.com/widgetbook/widgetbook/pull/819))
- **FIX**: Remove unused imports. ([#786](https://github.com/widgetbook/widgetbook/pull/786))

## 3.0.0

Check out the [migration guide](https://docs.widgetbook.io/migration/2.4.0-to-3.0.0) for more information.

## 3.0.0-rc.2

- **BREAKING**: Change generated extension from `.g.dart` to `.directories.g.dart` to avoid conflicting outputs with other generators. ([#737](https://github.com/widgetbook/widgetbook/pull/737))
- **BREAKING**: Remove `@App` annotation's `foldersExpanded` and `widgetsExpanded` non-working parameters. ([#735](https://github.com/widgetbook/widgetbook/pull/735))
- **REFACTOR**: Add meta comments to header. ([#745](https://github.com/widgetbook/widgetbook/pull/745))

## 3.0.0-rc.1

- Check out the [migration guide](https://docs.widgetbook.io/~docs%2Fwidgetbook-3/migration/3.0.0-beta-to-rc) for more details.
- **FEAT**: Add Dart 3 and Flutter 3.10 support. ([#676](https://github.com/widgetbook/widgetbook/pull/676))
- **BREAKING**: Drop Flutter 2 support. ([#676](https://github.com/widgetbook/widgetbook/pull/676))
- **BREAKING**: Remove code generation support for everything except `@App` and `@UseCase` that generate a list called `directories`. You should now configure Widgetbook's properties (i.e. `addons`, `appBuilder`, etc.) manually. ([#663](https://github.com/widgetbook/widgetbook/pull/663))
- **FIX**: Remove `<dynamic>` from Generic Widgets names. ([#700](https://github.com/widgetbook/widgetbook/pull/700))
- **REFACTOR**: Drop `freezed` dependency. ([#666](https://github.com/widgetbook/widgetbook/pull/666))

## 3.0.0-beta.11

- **REFACTOR**: :recycle: removed package analysis_options files.
- **REFACTOR**: :recycle: warnings.

## 3.0.0-beta.10

- **FIX**: :bug: expects data that does not exist. ([6396e411](https://github.com/widgetbook/widgetbook/commit/6396e41129c586fdbcde5ce6dabb0f1a8fbfbe9e))

## 3.0.0-beta.9

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
