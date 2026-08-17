# customer_issue_2018

Reproduction for [#2018](https://github.com/widgetbook/widgetbook/issues/2018):
images are missing from generated snapshots.
Fixed by [#2019](https://github.com/widgetbook/widgetbook/pull/2019).

## Layout

Mirrors the setup from the issue:

- `assets/`: Flutter package that owns `images/knob.png`, a solid magenta 40x40
  image.
- `widgetbook/`: Widgetbook project depending on `assets`. `SettingToggle` is
  the widget from the issue and loads the knob via
  `Image.asset('images/knob.png', package: 'assets')`. `LocalAssetToggle` is the
  same widget but loads `images/local_knob.png`, a solid green 40x40 image
  declared by the Widgetbook project itself.

## Run it

```sh
cd widgetbook
flutter pub get
dart run build_runner build
flutter test
```

`test/widgetbook_test.dart` generates the snapshots and then reads them back,
asserting that each knob's color is actually present in the written PNG.

Which Widgetbook the demo runs against is decided by the `widgetbook` path in
`pubspec_overrides.yaml`:

| Path                                            | Result                                       |
| :---------------------------------------------- | :------------------------------------------- |
| `../../../../fix-2018-images/packages/widgetbook` | passes, both knobs are painted             |
| `../../../packages/widgetbook`                  | fails, both snapshots have a blank 40x40 box |

Re-run `flutter pub get` after switching.

## What the bug was

Neither the package asset nor the project-owned one was painted, so the problem
was never about the package boundary: any `Image.asset` was blank.
`testWidgetbook` pumped and rasterized the scenario without giving image
providers a real async gap, so `AssetImage` resolution (file I/O plus
`instantiateImageCodec`) could not complete before the capture.
Fonts were already loaded up front by `loadFonts()`, images had no equivalent.

The web build was unaffected, which is why the widget looked correct in the
browser: `flutter build web --target lib/widgetbook.dart` ships both
`assets/images/local_knob.png` and `assets/packages/assets/images/knob.png`.
