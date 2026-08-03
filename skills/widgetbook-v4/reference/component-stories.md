# Component stories: the fast path

How to add a component's stories so it is browsable, snapshot-tested, and right the first time. Read alongside `api-reference.md` (the API surface) — this file is the *shape* and the *traps* that otherwise cost several iterations.

## The shape that works

**One `$Story` per meaningful state/variant.** In the running app the navigator shows one render per story, using that story's default args. Scenarios do **not** appear in the app — they only render under `flutter test`. So anything you want to *browse* (each state, each type) must be its own `$Story`, not a scenario.

- Set each story's state through story-level `args:` (interactive `_Args(...)`), so it renders that state live *and* stays tweakable from the knobs panel.
- Reserve `scenarios` for test-only concerns: the accessibility assertion, or an extra snapshot you don't need as a nav entry.
- Don't add a "Playground" catch-all unless you specifically want a blank knob sandbox — each state story already exposes the knobs.

```dart
final $Filled = _Story(name: 'Filled', args: _Args(value: StringArg('jane@example.com')));
final $Focus  = _Story(name: 'Focus',  args: _Args(autofocus: BoolArg(true)));
final $Error  = _Story(name: 'Error',  args: _Args(errorText: StringArg('Required')));
```

**Make every state reachable from args, not `run`.** Give the widget the props it needs to *show* a state statically — e.g. `initialValue` (seed text → Filled) and `autofocus` (→ Focus). Then each state is one `$Story` with fixed args and renders identically in the app and in snapshots. A `run` step only executes under `flutter test`, so a state built with `run` looks empty in the live app.

**Widgets with callbacks/controllers need a knobs bag.** A constructor with `onChanged`, a controller, or a focus node is a poor `Args` source. Define a plain data class of just the visual inputs, point `Meta` at it with `argsType:`, and assemble the real widget in a `defaults` builder — which **must return the widget type**, no wrappers:

```dart
class MyFieldKnobs {
  const MyFieldKnobs({this.label = '', this.value = '', this.enabled = true});
  final String label; final String value; final bool enabled;
}
const meta = Meta(MyField.new, argsType: MyFieldKnobs.new);
final defaults = _Defaults(
  builder: (context, args) => MyField(              // return MyField — not SizedBox(child: MyField(...))
    label: args.label.isEmpty ? null : args.label,
    initialValue: args.value.isEmpty ? null : args.value,
    enabled: args.enabled,
    onChanged: (_) {},
  ),
);
```

## Register in BOTH places

Adding a component touches two files, and forgetting the second is silent:

1. `widgetbook/lib/widgetbook.config.dart` — for the running app.
2. the golden test's `Config.components` (e.g. `widgetbook/test/widgetbook_test.dart`) — for `flutter test`.

The test harness keeps its own component list; a component registered only in the config renders **zero** snapshots with no error — the test count just doesn't rise. After registering, run `flutter test` and confirm the count went up. **Better setup:** export the component list from `config` and import it in the test (`components: config.components`) so there is one source of truth — the test still needs its own `appBuilder`/surface, but the list is shared.

## Viewport: none by default

Don't put a `ViewportMode` on a single-component story — it frames a lone button in a phone-sized canvas. Let components render at their natural size:

- **App config**: `addons: [ViewportAddon([Viewports.none])]` (add devices to the list for optional framing).
- **Story**: no viewport at all.

`Viewports.none` produces *unbounded* constraints, and a `MaterialApp`/`Scaffold` cannot lay out unbounded — so the **golden test bounds its own root** with a fixed `SizedBox`:

```dart
appBuilder: (context, child) => SizedBox(
  width: 400, height: 320,               // establishes bounds under `none`
  child: MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: Center(child: child)),
  ),
),
```

A `ViewportMode` on a story applies in **both** the app and the test, so you can't set `none` there without breaking the golden render. Keep the viewport out of the story; bound the test surface instead.

## Screens / full-page widgets

A full screen (a `Scaffold` or any widget that owns its page layout) is the one case that inverts the "viewport: none" rule — it **must** have a device viewport, and it **does** go in the golden test (at a phone-sized surface). A screen is where responsive overflow lives, so it needs the visual snapshot most.

- **Story:** a `$Story` with a device `ViewportMode`, catalogued under `path: 'Screens'`. `Viewports.none` is unbounded and a `Scaffold` can't lay out in it, so pin a real device:
  ```dart
  const component = ComponentMeta(name: 'Home', path: 'Screens');
  const meta = Meta(HomeScreen.new);
  final $Home = _Story(name: 'Home', modes: [ViewportMode(IosViewports.iPhone13ProMax)]);
  ```
  The device must be present in the `ViewportAddon` of **both** the app `config` and the golden test's `Config`, or the `ViewportMode` throws `Modes [ViewportMode] do not have a corresponding addon in config`. Register `<Name>Component` in both component lists. Keep a Flutter import (`package:flutter/widgets.dart`) in the story file so the generated `Key` reference resolves.
- **Add a narrowest-device story.** Overflow hides at a comfortable width and only bites at the smallest one, so pin a second story to the smallest device you support (iPhone SE, 375px) via `setup` — this is the snapshot that catches a `RenderFlex` overflow a 390px render sails right past:
  ```dart
  final $HomeIPhoneSE = _Story(
    name: 'Home · iPhone SE',
    setup: (context, child, args) => Center(
      child: SizedBox(
        width: IosViewports.iPhoneSE.maxWidth,
        height: IosViewports.iPhoneSE.maxHeight,
        child: child,
      ),
    ),
  );
  ```
- **Size the golden harness for screens.** A full `Scaffold` won't fit a small component surface, so set the golden test's root `SizedBox` to phone-portrait (e.g. `Size(390, 844)`); leaf components are small and simply centre within it.
- **Keep a plain widget test for semantics** — pump the screen at a device size and assert content (`find.text(...)`, theme colours):
  ```dart
  testWidgets('HomeScreen renders its sections', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(MaterialApp(theme: AppTheme.light, home: const HomeScreen()));
    expect(find.text('Good morning, Alex'), findsOneWidget);
  });
  ```
  It's a useful content/semantics check but **not** a substitute for the narrow-device snapshot — a single-width test that only asserts text presence passes straight over an 11px overflow.

## Accessibility

Assert `labeledTapTargetGuideline` + `textContrastGuideline` always. Assert tap-target-size (`androidTapTargetGuideline` 48dp / `iOSTapTargetGuideline` 44dp) only for a size the component actually meets — a 44px field or an `sm` button fails these by design, so skip them or assert on a size/state that passes, and note why in a comment. Put the assertion in a `run` scenario on the most-interactive state.

## Gotchas (symptom → cause → fix)

| Symptom | Cause | Fix |
|---|---|---|
| New component renders 0 snapshots; count doesn't rise | Registered in the app config but not the golden test's `components` | Add `<Name>Component` to both (or share one list) |
| States "all look the same" in the running app | States encoded as `scenarios` (test-only) | One `$Story` per state, state set via story-level `args` |
| A state built with `run` looks empty in the app | `run` executes only under `flutter test` | Express the state via args (`initialValue`, `autofocus`, `errorText`, …) |
| `Modes [ViewportMode] do not have a corresponding addon` (in the app, or in `flutter test` once a screen is in the golden) | Story uses `ViewportMode`, but that `Config`'s `ViewportAddon` doesn't list the device | Add the device to the `ViewportAddon` in **both** the app `config` and the golden test's `Config` |
| `BoxConstraints(unconstrained)` / unbounded crash in `flutter test` | `Viewports.none` is unbounded; an app can't lay out in it | Bound the golden test's root with a fixed `SizedBox` |
| `_Defaults(builder:)` won't compile ("can't return 'SizedBox'") | The builder must return the widget type | Don't wrap; give the widget the prop it needs |
| `EnumArg(E.x)` → "Required named parameter 'values'" | beta API | `EnumArg(E.x, values: E.values)` |
| "The class 'Story' is abstract" | Instantiated `Story<...>` directly | Use the generated `_Story`, or a concrete subclass (e.g. `FoundationStory`) |
| A `$Story` with `scenarios` loses its auto "Default" snapshot | Explicit scenarios replace the auto one | Add an explicit `default` scenario if you want both |
