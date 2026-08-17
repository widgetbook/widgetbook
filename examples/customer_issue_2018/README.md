# customer_issue_2018

Reproduction for [#2018](https://github.com/widgetbook/widgetbook/issues/2018):
images are missing from generated snapshots.

## Layout

Mirrors the setup from the issue:

- `assets/`: Flutter package that owns `images/knob.png`, a solid magenta 40x40
  image.
- `widgetbook/`: Widgetbook project depending on `assets`. `SettingToggle` is
  the widget from the issue and loads the knob via
  `Image.asset('images/knob.png', package: 'assets')`. `LocalAssetToggle` is the
  same widget but loads `images/local_knob.png`, a solid green 40x40 image
  declared by the Widgetbook project itself.

## Reproduce

```sh
cd widgetbook
flutter pub get
dart run build_runner build
flutter test
```

The snapshots under `build/.widgetbook/**/Default.png` have the expected size,
layout and text, but no knob: the 40x40 box where the image belongs stays
background-colored.

## What it shows

`flutter test test/asset_snapshot_test.dart` rasterizes the same way
`testWidgetbook` does and counts the knob's pixels:

| Scenario                                            | Result                     |
| :-------------------------------------------------- | :------------------------- |
| asset from a dependency package, no async gap        | fails, 0 knob pixels       |
| asset owned by the Widgetbook project, no async gap  | fails, 0 knob pixels       |
| both assets precached inside `tester.runAsync`       | passes, both knobs painted |

Two conclusions: the problem is not specific to package assets (any
`Image.asset` is blank in snapshots), and the assets are declared and bundled
correctly, since precaching them makes them appear.

`testWidgetbook` pumps the scenario and rasterizes it without ever giving image
providers a real async gap, so `AssetImage` resolution (file I/O plus
`instantiateImageCodec`) cannot complete before the capture.
Fonts are loaded up front by `loadFonts()`, images have no equivalent.

The web build is unaffected, which is why the widget looks correct in the
browser: `flutter build web --target lib/widgetbook.dart` ships both
`assets/images/local_knob.png` and `assets/packages/assets/images/knob.png`.
