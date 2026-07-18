# integration_test_example

Prototype for capturing Widgetbook snapshots of components that use
platform-specific plugins — here `video_player` and `pdfrx` — which render
**blank** under `flutter test`.

## Why

`flutter test` runs on `TestWidgetsFlutterBinding` (the Dart VM, no real
engine/GPU) and snapshots widgets with `OffsetLayer.toImage`, which only
rasterizes the Flutter layer tree. Native platform textures/views (a decoded
video frame, a PDFium-rendered page) are never in that tree, so they come out
empty.

This example runs the same Widgetbook scenarios on a real device/simulator via
`package:integration_test`, where the plugins render for real and are included
in an on-device screenshot. It reuses the existing Widgetbook scenario model
(`Scenario.run` still receives a real `WidgetTester`) and writes the results
into the same `build/.widgetbook` cache the Widgetbook CLI uploads.

## Layout

- `lib/video_demo.dart` / `lib/pdf_demo.dart` — components backed by the native
  plugins.
- `lib/*.stories.dart` — Widgetbook stories. The `video_demo` scenarios use
  `Scenario.run` to reach into the running `VideoPlayerController` via the
  `WidgetTester` and seek to a deterministic frame before the snapshot — the
  interaction you lose with a pure device-farm screenshot.
- `assets/sample.mp4`, `assets/sample.pdf` — deterministic fixtures.
- `integration_test/widgetbook_test.dart` — entrypoint:
  `testWidgetbookOnDevice(config)` from `package:widgetbook/integration_test.dart`.
- `test_driver/integration_test.dart` — host side; writes screenshot bytes and
  per-scenario metadata into `build/.widgetbook/<Component>/<Story>/<Scenario>.{png,json}`.
- `integration_test/m0_capture_test.dart` — a minimal smoke test proving raw
  native-plugin capture, independent of Widgetbook.

## Run

Boot an iOS simulator (or attach a device), then:

```sh
flutter pub get
dart run build_runner build          # generate *.stories.g.dart + components.g.dart
flutter drive \
  --driver test_driver/integration_test.dart \
  --target integration_test/widgetbook_test.dart \
  -d <ios-simulator-or-device>
```

Snapshots and metadata land in `build/.widgetbook/`. From there the existing
`widgetbook cloud build push` uploads them unchanged — no cloud-side changes are
needed, because the v4 ingest already accepts client-rendered PNGs + metadata.

## Known considerations

- **Full-screen capture.** `integration_test` screenshots capture the whole
  device surface, not the widget bounds; the component is centered with device
  margins. Cropping to the repaint boundary is a follow-up.
- **Viewport modes.** On-device capture uses the real device resolution and
  pixel ratio; `ViewportMode` is not yet applied to the surface.
- **Video determinism.** Video is non-deterministic frame-to-frame. The
  scenarios seek to a fixed position and briefly nudge playback so the seeked
  frame reaches the platform texture (while paused, iOS keeps the display link
  idle and won't push a new frame). Prefer a deterministic fixture per scenario.
- **Platform support.** `takeScreenshot` is implemented natively on iOS and
  Android (Android additionally needs `convertFlutterSurfaceToImage()`, handled
  by the binding). macOS needs the `integration_test_macos` package.
