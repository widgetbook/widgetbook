## Unreleased

- **BREAKING**: Set minimum SDK version to 3.3.0 & minimum Flutter version to 3.19.0. ([#1349](https://github.com/widgetbook/widgetbook/pull/1349))

## 3.10.2

- **FEAT**: Add `WidgetbookState.maybeOf`. ([#1342](https://github.com/widgetbook/widgetbook/pull/1342) - by [@ABausG](https://github.com/ABausG))

## 3.10.1

- **FIX**: Expose `WidgetbookScope` to allow importing it in tests. ([#1325](https://github.com/widgetbook/widgetbook/pull/1325))
- **FIX**: Allow special characters in search query. ([#1293](https://github.com/widgetbook/widgetbook/pull/1293) - by [@07Abhinavkapoor](https://github.com/07Abhinavkapoor))

## 3.10.0

- **REFACTOR**: Use a slider instead of a dropdown for `TextScaleAddon`. The `scales` parameter is deprecated, and can be removed or replaced with a combination of `min`, `max` and `divisions` parameters if the default values are not sufficient. ([#1224](https://github.com/widgetbook/widgetbook/pull/1224) - by [@ash14](https://github.com/ash14))
- **REFACTOR**: Expand `DropdownMenu` to the full width of the sidebar. ([#1287](https://github.com/widgetbook/widgetbook/pull/1287))
- **REFACTOR**: Use tabs instead of accordion for the sidebar. ([#1290](https://github.com/widgetbook/widgetbook/pull/1290))

## 3.9.0

- **BREAKING**: Set minimum SDK version to 3.0.0 & minimum Flutter version to 3.16.0. ([#1243](https://github.com/widgetbook/widgetbook/pull/1243))
- **FEAT**: Allow changing Widgetbook's theme and mode. ([#1225](https://github.com/widgetbook/widgetbook/pull/1225) - by [@Mastersam07](https://github.com/Mastersam07))
- **REFACTOR**: Use `MediaQuery.textScaler` instead of `MediaQuery.textScaleFactor` for `TextScaleAddon`. ([#1244](https://github.com/widgetbook/widgetbook/pull/1244))
- **REFACTOR**: Use [`GridPaper`](https://api.flutter.dev/flutter/widgets/GridPaper-class.html) for `GridAddon`. ([#1259](https://github.com/widgetbook/widgetbook/pull/1259))
- **FIX**: Skip decoding non-ascii characters in URLs. ([#1218](https://github.com/widgetbook/widgetbook/pull/1218) - by [@shigomany](https://github.com/shigomany))
- **FIX**: Encode all fields values to allow reserved characters (e.g. commas, colons and curly brackets). ([#1214](https://github.com/widgetbook/widgetbook/pull/1214))
- **FIX**: Remove default value (i.e. first item) from `listOrNull` knob. ([#1233](https://github.com/widgetbook/widgetbook/pull/1233))
- **FEAT**: Improve duration knob. ([#1226](https://github.com/widgetbook/widgetbook/pull/1226) - by [@Mastersam07](https://github.com/Mastersam07))

## 3.8.1

- **FIX**: Show popup routes (e.g. dialogs and modal sheets) inside the boundaries on the device frame. ([#1209](https://github.com/widgetbook/widgetbook/pull/1209))

## 3.8.0

- **FIX**: Maintain theme in Flutter v3.22. ([#1184](https://github.com/widgetbook/widgetbook/pull/1184))
- **FIX**: Allow colons _(and other special characters)_ in fields' names. ([#1165](https://github.com/widgetbook/widgetbook/pull/1165) - by [@maudFrz](https://github.com/maudFrz))
- **FIX**: Guard `list` knob against null values when searching. ([#1152](https://github.com/widgetbook/widgetbook/pull/1152) - by [@bramp](https://github.com/bramp))
- **REFACTOR**: Deprecate `AccessibilityAddon` in favor of `BuilderAddon`. Check out the [setup guide](https://docs.widgetbook.io/addons/accessibility-addon) to know how to migrate. ([#1193](https://github.com/widgetbook/widgetbook/pull/1193))

## 3.7.1

- **REFACTOR**: Wrap workbench with `Scaffold`. ([#1091](https://github.com/widgetbook/widgetbook/pull/1091))
- **FIX**: Update `DoubleInputField` regex to accept more digits before the decimal point. ([#1117](https://github.com/widgetbook/widgetbook/pull/1117))
- **FIX**: Use `T` codecs for `NumInputField`; to differentiate between the parsing of `double` & `int`. ([#1118](https://github.com/widgetbook/widgetbook/pull/1118))
- **FIX**: Allow negative numbers for numeric field. ([#1119](https://github.com/widgetbook/widgetbook/pull/1119))

## 3.7.0

- **FIX**: Enable `InspectorAddon` on release builds. ([#1087](https://github.com/widgetbook/widgetbook/pull/1087))
- **EXPERIMENTAL**: Add `EnumArg`. ([#1073](https://github.com/widgetbook/widgetbook/pull/1073))
- **EXPERIMENTAL**: Add `SingleArg`. ([#1075](https://github.com/widgetbook/widgetbook/pull/1075))
- **EXPERIMENTAL**: Add `BuilderArg`. ([#1079](https://github.com/widgetbook/widgetbook/pull/1079))
- **EXPERIMENTAL**: Change `Arg.value` to be positional parameter instead of named one. ([#1077](https://github.com/widgetbook/widgetbook/pull/1077))
- **EXPERIMENTAL**: Allow overriding `Arg.name`. ([#1078](https://github.com/widgetbook/widgetbook/pull/1078))
- **EXPERIMENTAL**: Support custom args via `MetaWithArgs`. ([#1080](https://github.com/widgetbook/widgetbook/pull/1080))
- **EXPERIMENTAL**: Add `args` parameter to `Story.setup`. ([#1081](https://github.com/widgetbook/widgetbook/pull/1081))
- **EXPERIMENTAL**: Use `setup` in `Scenario`s. ([#1082](https://github.com/widgetbook/widgetbook/pull/1082))
- **EXPERIMENTAL**: Add `LeafComponent`. ([#1083](https://github.com/widgetbook/widgetbook/pull/1083))
- **EXPERIMENTAL**: Support optional parameters arg-generation. ([#1084](https://github.com/widgetbook/widgetbook/pull/1084))

## 3.6.0

- **REFACTOR**: Use const named constructors for `Widgetbook`, instead of static methods. ([#1066](https://github.com/widgetbook/widgetbook/pull/1066))
- **EXPERIMENTAL**: Add `setup` to `Story`. ([#1069](https://github.com/widgetbook/widgetbook/pull/1069))

## 3.5.0

- **FIX** Ignore deprecated `MediaQuery.textScaleFactor`; to maintain compatibility with Flutter versions < 3.16.0. ([#1053](https://github.com/widgetbook/widgetbook/pull/1053))
- **EXPERIMENTAL**: Add support for [SAM Architecture](https://docs.widgetbook.io/next/sam). ([#1064](https://github.com/widgetbook/widgetbook/pull/1064))

## 3.4.1

- **FIX**: Use `MediaQuery.of(context).size` instead of `MediaQuery.sizeOf`, to maintain compatibility with Flutter v3.7. ([#1049](https://github.com/widgetbook/widgetbook/pull/1049))
- **FIX**: Highlight selected `WidgetbookLeafComponent`. ([#1047](https://github.com/widgetbook/widgetbook/pull/1047))

## 3.4.0

- **BREAKING**: Set minimum SDK version to 2.19.0 & minimum Flutter version to 3.7.0. ([#1030](https://github.com/widgetbook/widgetbook/pull/1030))
- **FEAT**: Add mobile support. ([#1019](https://github.com/widgetbook/widgetbook/pull/1019) - by [@Mastersam07](https://github.com/Mastersam07))
- **FEAT**: Add light theme support. ([#919](https://github.com/widgetbook/widgetbook/pull/919) - by [@07Abhinavkapoor](https://github.com/07Abhinavkapoor))
- **FEAT**: Introduce `WidgetbookLeafComponent` navigation node for components with a single use-case. ([#1015](https://github.com/widgetbook/widgetbook/pull/1015))
- **FEAT**: Add `designLink` to `WidgetbookUseCase`. ([#926](https://github.com/widgetbook/widgetbook/pull/926) - by [@Mastersam07](https://github.com/Mastersam07))
- **FEAT**: Add spaces to `color` knob. ([#986](https://github.com/widgetbook/widgetbook/pull/986) - by [@francescovallone](https://github.com/francescovallone))
- **FEAT**: Add `colorOrNull` knob. ([#1027](https://github.com/widgetbook/widgetbook/pull/1027))
- **FEAT**: Add `duration` knob. ([#934](https://github.com/widgetbook/widgetbook/pull/934) - by [@Mastersam07](https://github.com/Mastersam07))
- **FEAT**: Add `dateTime` knob. ([#940](https://github.com/widgetbook/widgetbook/pull/940) - by [@logickoder](https://github.com/logickoder))
- **FEAT**: Add `int` knob. ([#942](https://github.com/widgetbook/widgetbook/pull/942) - by [@Mastersam07](https://github.com/Mastersam07))
- **FEAT**: Add [Inspector Addon](https://docs.widgetbook.io/addons/inspector-addon). ([#985](https://github.com/widgetbook/widgetbook/pull/985) - by [@Mastersam07](https://github.com/Mastersam07))
- **FEAT**: Add [Accessibility Addon](https://docs.widgetbook.io/addons/accessibility-addon). ([#1020](https://github.com/widgetbook/widgetbook/pull/1020))
- **FEAT**: Add [Grid Addon](https://docs.widgetbook.io/addons/grid-addon). ([#943](https://github.com/widgetbook/widgetbook/pull/943) - by [@Mastersam07](https://github.com/Mastersam07))
- **FEAT**: Add [Zoom Addon](https://docs.widgetbook.io/addons/zoom-addon). ([#968](https://github.com/widgetbook/widgetbook/pull/968) - by [@Mastersam07](https://github.com/Mastersam07))
- **FEAT**: Add `q` query param for search. ([#950](https://github.com/widgetbook/widgetbook/pull/950) - by [@boredcity](https://github.com/boredcity))
- **FIX**: Use `MapMixin` instead of `MapBase` for `KnobsRegistry`. ([#903](https://github.com/widgetbook/widgetbook/pull/903))
- **FIX**: Maintain navigation panel state on reload. ([#932](https://github.com/widgetbook/widgetbook/pull/932) - by [@khurramrizvi](https://github.com/khurramrizvi))
- **FIX**: Add default values for `slider` knobs' parameters. ([#1016](https://github.com/widgetbook/widgetbook/pull/1016))
- **FIX**: Change `booleanOrNull` knobs's `initialValue` to null; to match other `orNull` knobs. ([#1026](https://github.com/widgetbook/widgetbook/pull/1026))
- **FIX**: Add `DefaultTextStyle` to `ThemeAddon`s. ([#1041](https://github.com/widgetbook/widgetbook/pull/1041))
- **REFACTOR**: Deprecate `WidgetbookAddon`'s `initialSetting`. Should be replaced by a local field in relevant addons. ([#1023](https://github.com/widgetbook/widgetbook/pull/1023))
- **REFACTOR**: Deprecate `Field.onChanged`. ([#1024](https://github.com/widgetbook/widgetbook/pull/1024))
- **REFACTOR**: Deprecate `Knob.value` & `KnobsRegistry.updateValue` in favor of `Knob.initialValue`. ([#1025](https://github.com/widgetbook/widgetbook/pull/1025))
- **REFACTOR**: Add default value to `color` knobs's `initialValue` parameter. ([#1039](https://github.com/widgetbook/widgetbook/pull/1039))

## 3.3.0

- **FEAT**: Add Builder Addon. ([#895](https://github.com/widgetbook/widgetbook/pull/895))
- **FEAT**: Add Experimental Time Dilation Addon. ([#887](https://github.com/widgetbook/widgetbook/pull/887))
- **FEAT**: Add `WidgetbookState.updateQueryField`. ([#888](https://github.com/widgetbook/widgetbook/pull/888))
- **REFACTOR**: Change `WidgetbookState.knobs` type from `Map<String, Knob>` to `KnobsRegistry`. ([#885](https://github.com/widgetbook/widgetbook/pull/885))
- **REFACTOR**: Deprecate `WidgetbookState.updateKnobValue` in favor of `WidgetbookState.knobs.updateValue`. ([#885](https://github.com/widgetbook/widgetbook/pull/885))
- **FIX**: Remove false overriding for `listOrNull` knob. ([#881](https://github.com/widgetbook/widgetbook/pull/881))

## 3.2.0

- **BREAKING**: `DeviceFrameAddon.devices` is no longer nullable, in favor of the new `NoneDevice`. ([#854](https://github.com/widgetbook/widgetbook/pull/854))
- **REFACTOR**: Support Flutter 3.13.0. ([#847](https://github.com/widgetbook/widgetbook/pull/847))
- **REFACTOR**: Update `DropdownMenu` theme. ([#844](https://github.com/widgetbook/widgetbook/pull/844))
- **REFACTOR**: Make `appBuilder` optional. ([#843](https://github.com/widgetbook/widgetbook/pull/843))
- **REFACTOR**: Replace `MultiChildNavigationData` with `WidgetbookNode`. ([#833](https://github.com/widgetbook/widgetbook/pull/833))
- **REFACTOR**: Deprecate `WidgetbookUseCase.center` in favor of [AlignmentAddon]. ([#826](https://github.com/widgetbook/widgetbook/pull/826))
- **FIX**: Make `path` the first query parameter. ([#855](https://github.com/widgetbook/widgetbook/pull/855))
- **FIX**: Correct initial Checkbox value for null knobs. ([#851](https://github.com/widgetbook/widgetbook/pull/851))
- **FIX**: Ensure widget is mounted on change. ([#814](https://github.com/widgetbook/widgetbook/pull/814))
- **FIX**: Allow commas in `string` knobs. ([#817](https://github.com/widgetbook/widgetbook/pull/817))
- **FIX**: Correct `listOrNull` knob type cast. ([#818](https://github.com/widgetbook/widgetbook/pull/818))

## 3.1.0

- **FEAT**: Add Alignment Addon. ([#798](https://github.com/widgetbook/widgetbook/pull/798))
- **FEAT**: Add `initialRoute`. ([#794](https://github.com/widgetbook/widgetbook/pull/794))
- **FEAT**: Preserve current state on web after doing hot restart or refresh from the browser. ([#782](https://github.com/widgetbook/widgetbook/pull/782))
- **BREAKING**: Replace the `Scaffold` around use-cases with a `ColoredBox` below the `Theme` widget. **`ThemeAddon` should be now added to `Widgetbook.addons` after the `DeviceFrameAddon`, and not before as in previous versions**. ([#789](https://github.com/widgetbook/widgetbook/pull/789))
- **FIX**: Add `Material` widget through default `appBuilder` of `Widgetbook.material`. ([#792](https://github.com/widgetbook/widgetbook/pull/792))

## 3.0.0

Check out the [migration guide](https://docs.widgetbook.io/migration/2.4.0-to-3.0.0) for more information.

## 3.0.0-rc.2

- **FEAT**: Support hot reloading. ([#759](https://github.com/widgetbook/widgetbook/pull/759))
- **FEAT**: Make side panels resizable. ([#738](https://github.com/widgetbook/widgetbook/pull/738))
- **FEAT**: Add `listOrNull` knob. ([#741](https://github.com/widgetbook/widgetbook/pull/741))
- **FEAT**: Add `initialOption` to `list` knob. ([#733](https://github.com/widgetbook/widgetbook/pull/733))
- **BREAKING**: Create `FieldsComposable` to unify addons/knobs APIs. ([#749](https://github.com/widgetbook/widgetbook/pull/749))
- **REFACTOR**: Add `SafeArea` to device addon. ([#760](https://github.com/widgetbook/widgetbook/pull/760))
- **REFACTOR**: Move `widgetbook_core` package to `widgetbook` package. ([#742](https://github.com/widgetbook/widgetbook/pull/742))
- **REFACTOR**: Export `WidgetbookState`. ([#724](https://github.com/widgetbook/widgetbook/pull/724))
- **REFACTOR**: Export fields to be used for custom addons/knobs. ([#728](https://github.com/widgetbook/widgetbook/pull/728))
- **REFACTOR**: Make `KnobsBuilder.onKnobAdded` public. ([#727](https://github.com/widgetbook/widgetbook/pull/727))
- **REFACTOR**: Add value label to `double.slider` knob. ([#757](https://github.com/widgetbook/widgetbook/pull/757))
- **FIX**: Use addons/knobs initial values. ([#746](https://github.com/widgetbook/widgetbook/pull/746))
- **FIX**: Use related type checks when comparing device's frame state to its query parameter. ([#715](https://github.com/widgetbook/widgetbook/pull/715))
- **FIX**: Add missing type parameter to `LabelBuilder`, which affected the `list` knob. ([#718](https://github.com/widgetbook/widgetbook/pull/718))
- **FIX**: Use `labelBuilder`-based string comparison in `list` knob. ([#729](https://github.com/widgetbook/widgetbook/pull/729))
- **FIX**: Add `key` to use cases to prevent out-of-sync builds. ([#720](https://github.com/widgetbook/widgetbook/pull/720))
- **Fix**: Prevent `onNodeSelected` from being called if the node is already selected. ([#725](https://github.com/widgetbook/widgetbook/pull/725))
- **Fix**: Use `ListView` for `SettingsPanel`. ([#732](https://github.com/widgetbook/widgetbook/pull/732))
- **Fix**: Use fresh `context` while retrieving state to avoid out-of-sync UI. ([#751](https://github.com/widgetbook/widgetbook/pull/751))

## 3.0.0-rc.1

- Check out the [migration guide](https://docs.widgetbook.io/~docs%2Fwidgetbook-3/migration/3.0.0-beta-to-rc) for more details.
- **FEAT**: Add Dart 3 and Flutter 3.10 support. ([#676](https://github.com/widgetbook/widgetbook/pull/676))
- **FEAT**: Add `buildUseCase` methods to Addons, that act as micro-`appBuilder`s. ([#646](https://github.com/widgetbook/widgetbook/pull/646))
- **FEAT**: Add `preview` query param instead of `disable-navigation`, `disable-properties` and `panels` query params. ([#687](https://github.com/widgetbook/widgetbook/pull/687))
- **FEAT**: Create `WidgetbookState`. ([#674](https://github.com/widgetbook/widgetbook/pull/674))
- **FEAT**: Add `integrations` and `WidgetbookCloudIntegration`. ([#689](https://github.com/widgetbook/widgetbook/pull/689))
- **BREAKING**: Drop Flutter 2 support. ([#676](https://github.com/widgetbook/widgetbook/pull/676))
- **BREAKING**: Use type-based knob names. ([#695](https://github.com/widgetbook/widgetbook/pull/695))
- **BREAKING**: Cleanup Addons constructors by removing the `setting` parameter. ([#652](https://github.com/widgetbook/widgetbook/pull/652))
- **BREAKING**: Remove `FrameAddon` in favor of the new `DeviceFrameAddon`. ([#632](https://github.com/widgetbook/widgetbook/pull/632), [#686](https://github.com/widgetbook/widgetbook/pull/686))
- **BREAKING**: Rename `WidgetbookAddOn` to `WidgetbookAddon`. ([#711](https://github.com/widgetbook/widgetbook/pull/711))
- **BREAKING**: Remove `configureMaterialAddons` and `configureCupertinoAddons` functions. ([#677](https://github.com/widgetbook/widgetbook/pull/677))
- **REFACTOR**: Drop `provider` dependency. ([#682](https://github.com/widgetbook/widgetbook/pull/682))
- **REFACTOR**: Drop `go_router` dependency. ([#625](https://github.com/widgetbook/widgetbook/pull/625))
- **REFACTOR**: Drop `flutter_bloc` dependency. ([#705](https://github.com/widgetbook/widgetbook/pull/705))
- **REFACTOR**: Drop `freezed` dependency. ([#703](https://github.com/widgetbook/widgetbook/pull/703))
- **REFACTOR**: Made `Widgetbook`'s `addons` parameter optional. ([#690](https://github.com/widgetbook/widgetbook/pull/690))
- **FIX**: Remove `StyledScaffold` that made focus not work properly. ([#650](https://github.com/widgetbook/widgetbook/pull/650))

## 3.0.0-beta.14

- **REFACTOR**: :recycle: addon multi property preview.
- **REFACTOR**: :recycle: removed package analysis_options files.
- **REFACTOR**: :recycle: warnings.
- **REFACTOR**: :recycle: `AddOn` API.
- **REFACTOR**: :recycle: improve API interface of addons.
- **REFACTOR**: :recycle: warnings.
- **REFACTOR**: :recycle: settings.
- **REFACTOR**: navigation logic.
- **REFACTOR**: 🛠️ uses new `NavigationTree`.
- **REFACTOR**: :recycle: adjust content.
- **REFACTOR**: :recycle: adjust generator to `AddOn` implemementation.
- **REFACTOR**: :zap: refactored addons.
- **REFACTOR**: `DeviceAddon`.
- **REFACTOR**: adjusted code to match linter.
- **FIX**: :test_tube: fixed broken test.
- **FIX**: :bug: requires `directories` to be not empty.
- **FIX**: :bug: properties resetting when changing locale.
- **FIX**: :bug: properties not changing on navigate.
- **FIX**: inserted scaffold messenger.
- **FIX**: expanding of elements within the navigation is not working.
- **FIX**: :bug: addons property cannot be empty.
- **FIX**: navigation tree collapsing and expanding does not work.
- **FIX**: orientation defaults to landscape.
- **FIX**: :bug: provider not found.
- **FIX**: knob values do not update when usecase changes.
- **FIX**: :bug: remove `go_router` diagnostics.
- **FIX**: :bug: improve Canvas.
- **FIX**: :bug: navigation resets when use case changes.
- **FIX**: :bug: addons show incorrect item.
- **FIX**: custom painter Widgets are incorrectly rendered.
- **FIX**: :bug: hot reload of directories.
- **FIX**: :bug: selected items not shown for addon.
- **FIX**: dialog shows up in Widgetbook instead of the simulated device.
- **FIX**: add packages/widgetbook prefix.
- **FIX**: change ttf files with fonts.google ones.
- **FIX**: :bug: ignores country codes.
- **FIX**: added MediaQuery for WidgetbookDeviceFrame.
- **FIX**: preview app shows debug banner.
- **FIX**: preview app shows debug banner in other theme than material.
- **FIX**: useCaseBuilder is called with old context.
- **FEAT**: :sparkles: addon multi property preview.
- **FEAT**: :sparkles: addon routing.
- **FEAT**: :sparkles: text scale addon.
- **FEAT**: :sparkles: device addon.
- **FEAT**: :sparkles: cupertino theme addon.
- **FEAT**: :sparkles: remove obsolete classes.
- **FEAT**: :sparkles: theme addon.
- **FEAT**: :sparkles: Theme needs to be accessible via the app builder function.
- **FEAT**: :zap: added text knob multiline.
- **FEAT**: :zap: added text knob multiline.
- **FEAT**: :zap: added color knob.
- **FEAT**: add `panels` query param ([#612](https://github.com/widgetbook/widgetbook/issues/612)).
- **FEAT**: added feature to toggle the orientation of a device.
- **FEAT**: added textScaleFactors for font accessibility.
- **FEAT**: :sparkles: addons and localization addon.
- **DOCS**: added how to use widgetbook with a package.

## 3.0.0-beta.13

- **FIX**(widgetbook): :bug: remove `go_router` diagnostics. ([a5395ee7](https://github.com/widgetbook/widgetbook/commit/a5395ee71461debfe22eaeef0b830c619ca01678))

## 3.0.0-beta.12

- Update a dependency to the latest release.

## 3.0.0-beta.11

- **FIX**: :bug: requires `directories` to be not empty. ([8e9b7aa1](https://github.com/widgetbook/widgetbook/commit/8e9b7aa168052f604e634b778c1fc500a9d0c6cb))

## 3.0.0-beta.10

- **REFACTOR**: :recycle: `AddOn` API. ([31734f9e](https://github.com/widgetbook/widgetbook/commit/31734f9ed6b5de14979308c9bf1825dab2ecc99e))
- **FIX**: :bug: addons property cannot be empty. ([67e1734f](https://github.com/widgetbook/widgetbook/commit/67e1734f556df61fbbbd8231464bbb66b86c38d2))

## 3.0.0-beta.9

- **REFACTOR**: :zap: refactored addons. ([16c007ee](https://github.com/widgetbook/widgetbook/commit/16c007eeb0a8fc6fa601332751a93a87d5e2b77d))
- **REFACTOR**: :recycle: warnings. ([8bf0b124](https://github.com/widgetbook/widgetbook/commit/8bf0b12447bf05ac35879000d5ff64ce27244290))
- **REFACTOR**: :recycle: settings. ([254ebef6](https://github.com/widgetbook/widgetbook/commit/254ebef6fe38b2d8f3fc847366f4725ab9292ccb))
- **REFACTOR**: navigation logic. ([9d254141](https://github.com/widgetbook/widgetbook/commit/9d2541417d4f3f6a70c15a92f87f6698bb47a4e6))
- **REFACTOR**: 🛠️ uses new `NavigationTree`. ([ba362c58](https://github.com/widgetbook/widgetbook/commit/ba362c580ac6b88200ef43fb4492e832c9c2769c))
- **REFACTOR**: :recycle: adjust content. ([46a4e184](https://github.com/widgetbook/widgetbook/commit/46a4e184abe212c241317ad5ac84575dc69ed026))
- **REFACTOR**: :recycle: adjust generator to `AddOn` implemementation. ([a91edbbf](https://github.com/widgetbook/widgetbook/commit/a91edbbf91500329bda9eb3882861b84527b9c4a))
- **REFACTOR**: `DeviceAddon`. ([091c2c18](https://github.com/widgetbook/widgetbook/commit/091c2c18d43cf54f7b8d3ea497222dc3b7366d70))
- **REFACTOR**: :recycle: improve API interface of addons. ([3d52df04](https://github.com/widgetbook/widgetbook/commit/3d52df04aa5d07ada5c8c0e334cb39aa582c1dc6))
- **REFACTOR**: adjusted code to match linter. ([04dd9f1e](https://github.com/widgetbook/widgetbook/commit/04dd9f1e6678e9d9531cb70c777281c4d050aa61))
- **REFACTOR**: :recycle: addon multi property preview. ([f2e01961](https://github.com/widgetbook/widgetbook/commit/f2e0196123495c151e6836231b12090d9c3bb8ec))
- **FIX**: :bug: ignores country codes. ([bd1d5ec5](https://github.com/widgetbook/widgetbook/commit/bd1d5ec5c73b11886d1d85e52e907f6c81304184))
- **FIX**: :bug: navigation resets when use case changes. ([86708225](https://github.com/widgetbook/widgetbook/commit/8670822534d401644306603af357fe99802c30e9))
- **FIX**: :bug: provider not found. ([9a072e77](https://github.com/widgetbook/widgetbook/commit/9a072e77ba815975a7258af4577f605168fcde6e))
- **FIX**: :bug: properties resetting when changing locale. ([bf9eebfc](https://github.com/widgetbook/widgetbook/commit/bf9eebfc8e6988ba7969ba7714dda08f67c4722c))
- **FIX**: :bug: properties not changing on navigate. ([3527d9c5](https://github.com/widgetbook/widgetbook/commit/3527d9c5081f9e4d4467f845238f8e629489d915))
- **FIX**: :test_tube: fixed broken test. ([6e56b79a](https://github.com/widgetbook/widgetbook/commit/6e56b79aada01a782d04f846c5ce2f126c98a575))
- **FIX**: inserted scaffold messenger. ([1181df1d](https://github.com/widgetbook/widgetbook/commit/1181df1d743cfda7d80855b658ca8214646aa29e))
- **FIX**: expanding of elements within the navigation is not working. ([096c296b](https://github.com/widgetbook/widgetbook/commit/096c296bc87a5e574981dde32546bc88b267fc65))
- **FIX**: navigation tree collapsing and expanding does not work. ([ba69d281](https://github.com/widgetbook/widgetbook/commit/ba69d281f1a91d0d71d275ab243c6d879ace72d8))
- **FIX**: :bug: hot reload of directories. ([077d142b](https://github.com/widgetbook/widgetbook/commit/077d142b4cf5a26821918b35dd84a4821ed8815b))
- **FIX**: orientation defaults to landscape. ([9e25a42a](https://github.com/widgetbook/widgetbook/commit/9e25a42aeaf6080a4019675e2ba53d3be0ac9754))
- **FIX**: :bug: improve Canvas. ([a179f8ee](https://github.com/widgetbook/widgetbook/commit/a179f8ee13981d18628d5c2e9efb0f0c74220487))
- **FIX**: :bug: addons show incorrect item. ([f54788e5](https://github.com/widgetbook/widgetbook/commit/f54788e5b55ca258dba4485dcfccb19e47483dbc))
- **FIX**: knob values do not update when usecase changes. ([f17c96da](https://github.com/widgetbook/widgetbook/commit/f17c96dae1697b9d2ce2a20ee10141a1aac9109f))
- **FIX**: useCaseBuilder is called with old context. ([e12b391d](https://github.com/widgetbook/widgetbook/commit/e12b391d31fca7c8be93581a33f49aa08f471aaa))
- **FIX**: :bug: selected items not shown for addon. ([5ea112f7](https://github.com/widgetbook/widgetbook/commit/5ea112f77b9c96c67d605662c7d7eb3d155b0c74))
- **FIX**: custom painter Widgets are incorrectly rendered. ([965c355e](https://github.com/widgetbook/widgetbook/commit/965c355e03cd7e9c9d62c473f1d29a006c07626e))
- **FIX**: dialog shows up in Widgetbook instead of the simulated device. ([42733f0b](https://github.com/widgetbook/widgetbook/commit/42733f0b6a93bffcdd90f0bb714788ff3619f313))
- **FIX**: add packages/widgetbook prefix. ([28ae9b51](https://github.com/widgetbook/widgetbook/commit/28ae9b51c58462c4039d0190b2e5195599c02e49))
- **FIX**: change ttf files with fonts.google ones. ([330452f6](https://github.com/widgetbook/widgetbook/commit/330452f64d95f9ebc9dd1606f6be376ceb7185a0))
- **FIX**: preview app shows debug banner. ([771fa430](https://github.com/widgetbook/widgetbook/commit/771fa43048f8f5e7f095bcd0bbb19f6f2f453f94))
- **FIX**: added MediaQuery for WidgetbookDeviceFrame. ([0160ce4a](https://github.com/widgetbook/widgetbook/commit/0160ce4af25d27bb3b6a3af7cb67bca41d7d4903))
- **FIX**: preview app shows debug banner in other theme than material. ([1f2e69a1](https://github.com/widgetbook/widgetbook/commit/1f2e69a1be0637d98007c37bafdc7dba7dc58320))
- **FEAT**: :sparkles: addon multi property preview. ([ab36f4e8](https://github.com/widgetbook/widgetbook/commit/ab36f4e884b862dd6c2c147d56cffcc7330109a9))
- **FEAT**: :sparkles: theme addon. ([74e6da54](https://github.com/widgetbook/widgetbook/commit/74e6da5421730b0dbc0a10d2d7307912a5a06919))
- **FEAT**: :sparkles: addon routing. ([8cfd3682](https://github.com/widgetbook/widgetbook/commit/8cfd3682073acc5b637a5ef60eaa78682e60283e))
- **FEAT**: :sparkles: text scale addon. ([db2a2b5f](https://github.com/widgetbook/widgetbook/commit/db2a2b5f04277f74f4f03a82e7b3012116fb1f96))
- **FEAT**: :sparkles: device addon. ([a2894879](https://github.com/widgetbook/widgetbook/commit/a28948799221bf90d403e3da1ccda065b8452e03))
- **FEAT**: :sparkles: cupertino theme addon. ([c7e5a013](https://github.com/widgetbook/widgetbook/commit/c7e5a013628638c51a8d9e8e315ff82914168051))
- **FEAT**: :sparkles: remove obsolete classes. ([d7384eae](https://github.com/widgetbook/widgetbook/commit/d7384eae9194c070d9d3e832b7a6ed41db79dc71))
- **FEAT**: :sparkles: Theme needs to be accessible via the app builder function. ([8a844098](https://github.com/widgetbook/widgetbook/commit/8a84409856ed7e42fc42ff765fb5af5fe41d8b11))
- **FEAT**: :zap: added text knob multiline. ([7c4e6d37](https://github.com/widgetbook/widgetbook/commit/7c4e6d372eda68159f55590c950d6054512b3eec))
- **FEAT**: :zap: added text knob multiline. ([af40092e](https://github.com/widgetbook/widgetbook/commit/af40092e9d1a81f738f35c77c22a0ec01df2995c))
- **FEAT**: :zap: added color knob. ([2b33ece0](https://github.com/widgetbook/widgetbook/commit/2b33ece088fddb7330828f245a6022a7d6f75ceb))
- **FEAT**: added feature to toggle the orientation of a device. ([ae42e4c8](https://github.com/widgetbook/widgetbook/commit/ae42e4c839002bee5cf5a8588b5e135460c8a011))
- **FEAT**: added textScaleFactors for font accessibility. ([19c3f93b](https://github.com/widgetbook/widgetbook/commit/19c3f93b026bbd04683f508f019f6859e707d91b))
- **FEAT**: :sparkles: addons and localization addon. ([03f91c29](https://github.com/widgetbook/widgetbook/commit/03f91c29ecf7bd953c6e79df7062d339523729ea))
- **DOCS**: added how to use widgetbook with a package. ([3e578b12](https://github.com/widgetbook/widgetbook/commit/3e578b125bb10dcaf0a8b89fc015610e363c0d1f))

## 3.0.0-beta.8

- **REFACTOR**: :recycle: addon multi property preview. ([f2e01961](https://github.com/widgetbook/widgetbook/commit/f2e0196123495c151e6836231b12090d9c3bb8ec))
- **REFACTOR**: :recycle: warnings. ([8bf0b124](https://github.com/widgetbook/widgetbook/commit/8bf0b12447bf05ac35879000d5ff64ce27244290))
- **REFACTOR**: :recycle: settings. ([254ebef6](https://github.com/widgetbook/widgetbook/commit/254ebef6fe38b2d8f3fc847366f4725ab9292ccb))
- **REFACTOR**: navigation logic. ([9d254141](https://github.com/widgetbook/widgetbook/commit/9d2541417d4f3f6a70c15a92f87f6698bb47a4e6))
- **REFACTOR**: 🛠️ uses new `NavigationTree`. ([ba362c58](https://github.com/widgetbook/widgetbook/commit/ba362c580ac6b88200ef43fb4492e832c9c2769c))
- **REFACTOR**: :recycle: adjust content. ([46a4e184](https://github.com/widgetbook/widgetbook/commit/46a4e184abe212c241317ad5ac84575dc69ed026))
- **REFACTOR**: `DeviceAddon`. ([091c2c18](https://github.com/widgetbook/widgetbook/commit/091c2c18d43cf54f7b8d3ea497222dc3b7366d70))
- **REFACTOR**: :recycle: adjust generator to `AddOn` implemementation. ([a91edbbf](https://github.com/widgetbook/widgetbook/commit/a91edbbf91500329bda9eb3882861b84527b9c4a))
- **REFACTOR**: :zap: refactored addons. ([16c007ee](https://github.com/widgetbook/widgetbook/commit/16c007eeb0a8fc6fa601332751a93a87d5e2b77d))
- **REFACTOR**: :recycle: improve API interface of addons. ([3d52df04](https://github.com/widgetbook/widgetbook/commit/3d52df04aa5d07ada5c8c0e334cb39aa582c1dc6))
- **REFACTOR**: adjusted code to match linter. ([04dd9f1e](https://github.com/widgetbook/widgetbook/commit/04dd9f1e6678e9d9531cb70c777281c4d050aa61))
- **FIX**: :bug: properties resetting when changing locale. ([bf9eebfc](https://github.com/widgetbook/widgetbook/commit/bf9eebfc8e6988ba7969ba7714dda08f67c4722c))
- **FIX**: expanding of elements within the navigation is not working. ([096c296b](https://github.com/widgetbook/widgetbook/commit/096c296bc87a5e574981dde32546bc88b267fc65))
- **FIX**: navigation tree collapsing and expanding does not work. ([ba69d281](https://github.com/widgetbook/widgetbook/commit/ba69d281f1a91d0d71d275ab243c6d879ace72d8))
- **FIX**: :bug: properties not changing on navigate. ([3527d9c5](https://github.com/widgetbook/widgetbook/commit/3527d9c5081f9e4d4467f845238f8e629489d915))
- **FIX**: knob values do not update when usecase changes. ([f17c96da](https://github.com/widgetbook/widgetbook/commit/f17c96dae1697b9d2ce2a20ee10141a1aac9109f))
- **FIX**: :bug: navigation resets when use case changes. ([86708225](https://github.com/widgetbook/widgetbook/commit/8670822534d401644306603af357fe99802c30e9))
- **FIX**: :bug: improve Canvas. ([a179f8ee](https://github.com/widgetbook/widgetbook/commit/a179f8ee13981d18628d5c2e9efb0f0c74220487))
- **FIX**: :test_tube: fixed broken test. ([6e56b79a](https://github.com/widgetbook/widgetbook/commit/6e56b79aada01a782d04f846c5ce2f126c98a575))
- **FIX**: :bug: addons show incorrect item. ([f54788e5](https://github.com/widgetbook/widgetbook/commit/f54788e5b55ca258dba4485dcfccb19e47483dbc))
- **FIX**: useCaseBuilder is called with old context. ([e12b391d](https://github.com/widgetbook/widgetbook/commit/e12b391d31fca7c8be93581a33f49aa08f471aaa))
- **FIX**: custom painter Widgets are incorrectly rendered. ([965c355e](https://github.com/widgetbook/widgetbook/commit/965c355e03cd7e9c9d62c473f1d29a006c07626e))
- **FIX**: :bug: selected items not shown for addon. ([5ea112f7](https://github.com/widgetbook/widgetbook/commit/5ea112f77b9c96c67d605662c7d7eb3d155b0c74))
- **FIX**: preview app shows debug banner in other theme than material. ([1f2e69a1](https://github.com/widgetbook/widgetbook/commit/1f2e69a1be0637d98007c37bafdc7dba7dc58320))
- **FIX**: inserted scaffold messenger. ([1181df1d](https://github.com/widgetbook/widgetbook/commit/1181df1d743cfda7d80855b658ca8214646aa29e))
- **FIX**: dialog shows up in Widgetbook instead of the simulated device. ([42733f0b](https://github.com/widgetbook/widgetbook/commit/42733f0b6a93bffcdd90f0bb714788ff3619f313))
- **FIX**: :bug: provider not found. ([9a072e77](https://github.com/widgetbook/widgetbook/commit/9a072e77ba815975a7258af4577f605168fcde6e))
- **FIX**: add packages/widgetbook prefix. ([28ae9b51](https://github.com/widgetbook/widgetbook/commit/28ae9b51c58462c4039d0190b2e5195599c02e49))
- **FIX**: change ttf files with fonts.google ones. ([330452f6](https://github.com/widgetbook/widgetbook/commit/330452f64d95f9ebc9dd1606f6be376ceb7185a0))
- **FIX**: preview app shows debug banner. ([771fa430](https://github.com/widgetbook/widgetbook/commit/771fa43048f8f5e7f095bcd0bbb19f6f2f453f94))
- **FIX**: added MediaQuery for WidgetbookDeviceFrame. ([0160ce4a](https://github.com/widgetbook/widgetbook/commit/0160ce4af25d27bb3b6a3af7cb67bca41d7d4903))
- **FIX**: orientation defaults to landscape. ([9e25a42a](https://github.com/widgetbook/widgetbook/commit/9e25a42aeaf6080a4019675e2ba53d3be0ac9754))
- **FEAT**: :sparkles: addon multi property preview. ([ab36f4e8](https://github.com/widgetbook/widgetbook/commit/ab36f4e884b862dd6c2c147d56cffcc7330109a9))
- **FEAT**: :sparkles: theme addon. ([74e6da54](https://github.com/widgetbook/widgetbook/commit/74e6da5421730b0dbc0a10d2d7307912a5a06919))
- **FEAT**: :sparkles: addon routing. ([8cfd3682](https://github.com/widgetbook/widgetbook/commit/8cfd3682073acc5b637a5ef60eaa78682e60283e))
- **FEAT**: :sparkles: text scale addon. ([db2a2b5f](https://github.com/widgetbook/widgetbook/commit/db2a2b5f04277f74f4f03a82e7b3012116fb1f96))
- **FEAT**: :sparkles: cupertino theme addon. ([c7e5a013](https://github.com/widgetbook/widgetbook/commit/c7e5a013628638c51a8d9e8e315ff82914168051))
- **FEAT**: :sparkles: remove obsolete classes. ([d7384eae](https://github.com/widgetbook/widgetbook/commit/d7384eae9194c070d9d3e832b7a6ed41db79dc71))
- **FEAT**: :sparkles: Theme needs to be accessible via the app builder function. ([8a844098](https://github.com/widgetbook/widgetbook/commit/8a84409856ed7e42fc42ff765fb5af5fe41d8b11))
- **FEAT**: :sparkles: device addon. ([a2894879](https://github.com/widgetbook/widgetbook/commit/a28948799221bf90d403e3da1ccda065b8452e03))
- **FEAT**: :zap: added text knob multiline. ([7c4e6d37](https://github.com/widgetbook/widgetbook/commit/7c4e6d372eda68159f55590c950d6054512b3eec))
- **FEAT**: :zap: added text knob multiline. ([af40092e](https://github.com/widgetbook/widgetbook/commit/af40092e9d1a81f738f35c77c22a0ec01df2995c))
- **FEAT**: :zap: added color knob. ([2b33ece0](https://github.com/widgetbook/widgetbook/commit/2b33ece088fddb7330828f245a6022a7d6f75ceb))
- **FEAT**: added feature to toggle the orientation of a device. ([ae42e4c8](https://github.com/widgetbook/widgetbook/commit/ae42e4c839002bee5cf5a8588b5e135460c8a011))
- **FEAT**: added textScaleFactors for font accessibility. ([19c3f93b](https://github.com/widgetbook/widgetbook/commit/19c3f93b026bbd04683f508f019f6859e707d91b))
- **FEAT**: :sparkles: addons and localization addon. ([03f91c29](https://github.com/widgetbook/widgetbook/commit/03f91c29ecf7bd953c6e79df7062d339523729ea))
- **DOCS**: added how to use widgetbook with a package. ([3e578b12](https://github.com/widgetbook/widgetbook/commit/3e578b125bb10dcaf0a8b89fc015610e363c0d1f))

## 3.0.0-beta.7

- refactor: navigation
- feat: adds `SettingPanel`

## 3.0.0-beta.6

- feat: depends on `widgetbook_core`

## 3.0.0-beta.5

- fix: properties are resetting when changing locale

## 3.0.0-beta.4

- fix: properties not changing `onNavigate` via the browser's URL bar

## 3.0.0-beta.3

- chore: bumped `widgetbook_models` version

## 3.0.0-beta.1

- improvements

## 2.4.1

- fix: failed to load font Nunito ([#206](https://github.com/widgetbook/widgetbook/issues/206))
- fix: preview app shows debug banner ([#202](https://github.com/widgetbook/widgetbook/issues/202))

## 2.4.0

- Added parameter `disable-navigation` and `disable-properties` to router.

## 2.3.0

- fix: Custom painter Widgets are incorrectly rendered ([#191](https://github.com/widgetbook/widgetbook/issues/191))
  - added property `appBuilder`.
- fix: Dialog shows up in Widgetbook instead of the simulated app ([#172](https://github.com/widgetbook/widgetbook/issues/172))
- fix: BottomSheet is showing up in Widgetbook instead of simulated app ([#190](https://github.com/widgetbook/widgetbook/issues/190))

## 2.2.2

- chore: updated docs to link to [docs.widgetbook.io](https://docs.widgetbook.io)

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
