---
name: widgetbook-v4
description: Write, generate, and work with Widgetbook v4 stories, args, scenarios, and component documentation for Flutter design systems. Use this skill whenever the user mentions Widgetbook, wants to write stories for Flutter widgets, wants to set up UI testing with Scenarios, wants to add accessibility testing to widgets, wants to catch visual bugs like overflows, wants to make a Flutter widget match its Figma design, wants to use Widgetbook in an agentic engineering workflow, or asks about visual regression testing or design review for Flutter. Also use when the user wants to connect Widgetbook Cloud to a Flutter CI pipeline, or asks about the difference between v3 and v4.
---

# Widgetbook v4

Widgetbook v4 generates a typed story API (`Meta`, `_Story`, `_Args`, `_Scenario`) from your Flutter widgets via `build_runner`, so stories are type-safe and readable by coding agents. Use it to catalogue widgets, snapshot every state, and verify UI against the design system and Figma.

This file is the working set. Load a reference file only when the task needs it:

- **`reference/api-reference.md`**: the full `Meta` / `Args` / `Scenario` / `Modes` / docs API, story-file conventions, a complete example, and the full mistakes list. Read before writing a non-trivial story or when unsure of a signature.
- **`reference/component-stories.md`**: the fast-path recipe for adding a component — one story per state, the knobs-bag pattern, viewport defaults, dual registration, and the gotchas that cost the most iterations. Read before adding a new component's stories.
- **`reference/figma-loop.md`**: the exact Figma MCP tool calls, node mapping, and recovery paths. Read when comparing against Figma.
- **`reference/migration.md`**: v3 and old-beta migrations. Read when touching legacy stories.
- **`reference/cloud-and-ci.md`**: Widgetbook Cloud and CI setup. Read for pipeline work.

## Workspace rule (non-negotiable)

The Widgetbook workspace is its own Flutter package that lives outside the app's `lib`, as a sibling `widgetbook/` folder. Never put Widgetbook or `*.stories.dart` inside `lib`. Story files live in `widgetbook/lib/`, mirroring the widget's path in the app. Run `dart run build_runner build -d` and `flutter test` from inside `widgetbook/`. Full layout and the app/workspace dependency setup are in `reference/api-reference.md`.

## API essentials

Enough to write a correct story. Full API in `reference/api-reference.md`.

- **Meta** uses a constructor tear-off and must be `const`: `const meta = Meta(AppButton.new);`. Declare one `Meta` per constructor; every `Meta` in a file targets the same widget.
- **Story**: `final $Primary = _Story(name: 'Primary', args: ...);`. Each story is a `$`-prefixed variable; set the display name with `name:`.
- **Args**: `_Args(label: StringArg('Save'), onPressed: Arg.fixed(() {}))` produces interactive knobs. `_Args.fixed(label: 'Save', onPressed: () {})` takes raw values with no knobs and is the usual form inside scenarios. Callbacks are never interactive.
- **Scenario**: one auto-snapshotted state, run under `flutter test`:
  ```dart
  scenarios: [_Scenario(name: 'Disabled', args: _Args.fixed(isEnabled: false))]
  ```
- **Accessibility**: assert Flutter's guideline matchers inside a scenario `run`:
  ```dart
  run: (tester, args) async {
    final handle = tester.ensureSemantics();
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  },
  ```
- Regenerate after any `Meta` or constructor change: `dart run build_runner build -d` inside `widgetbook/`.

## The agentic feedback loop

When you add or change a widget, run this loop until it converges. Do not stop early.

1. **Reflect the change.** Add or update the widget's `*.stories.dart` in `widgetbook/lib/`. Add **one `$Story` per meaningful state** (each is browsable in the app; scenarios are test-only and don't show there), plus a `meetsGuideline` scenario if the widget is interactive. Register the component in BOTH the app config and the golden test. See `reference/component-stories.md`.

2. **Run `flutter test`** from `widgetbook/`. It renders each scenario, writes a snapshot to `widgetbook/build/.widgetbook`, and fails on assertion errors and on layout errors including `RenderFlex` overflows. Read the named failure, fix it, and re-run until green.

3. **Map the widget to its Figma node.** Code Connect does not support Flutter, so there is no automatic widget-to-node mapping. Get the node from the user: the `fileKey` and `nodeId` parsed from a Figma link they provide, or the current selection when they are in the Figma desktop app. If you have a link to the frame but not the exact node, call `get_metadata` to list the document's nodes and match by layer name, then confirm with the user. If no node is available, skip steps 4 and 5 and note in the PR that the design comparison was skipped.

4. **Compare properties. This is the gate.** Call `get_variable_defs` for the node to get its tokens (colors, spacing, radius, typography), and `get_design_context` for structure when needed. Confirm the widget resolves the same design tokens, not just matching literals: if Figma specifies `colorScheme.error` at `#DC2626`, a hardcoded `Color(0xFFFF0000)` is a mismatch even when it looks close.

5. **Compare the render. This is a sanity check.** Call `get_screenshot` for the node and compare it against the Widgetbook snapshot from step 2. Look for structural differences in layout, spacing, sizing, and typography. Do not chase a pixel-exact match; anti-aliasing and font hinting always differ, so the property check in step 4 is what decides parity.

Iterate from step 1 until all three hold at once: `flutter test` is green with no overflow or layout errors, every token from `get_variable_defs` resolves to a token in the widget, and the render shows no structural difference from the Figma screenshot. Then open a PR. Tool details, node-id extraction, and recovery paths are in `reference/figma-loop.md`.

## Screens are widgets too — catalogue them

A screen (anything that returns a `Scaffold` or owns a full-page layout) is a widget in `lib/`, so the same rule applies: when you build or change a screen, give it a story. Do **not** leave an assembled screen as an untracked "composition" just because it only wires existing components together — if it's not in Widgetbook, no one can browse it and nothing snapshot-tests its layout. Build the screen by composing design-system widgets (extract any new repeated element as its own component with its own stories first), then catalogue the screen itself. Screens differ from leaf components in exactly two ways:

- **Viewport — a screen needs a device frame, not `Viewports.none`.** A `Scaffold` cannot lay out under the unbounded constraints that `Viewports.none` produces. Pin a device with a `ViewportMode` on the story so it gets bounded constraints (the device must be listed in the `ViewportAddon` in `widgetbook.config.dart`):
  ```dart
  const component = ComponentMeta(name: 'Home', path: 'Screens');
  const meta = Meta(HomeScreen.new);
  final $Home = _Story(name: 'Home', modes: [ViewportMode(IosViewports.iPhone13ProMax)]);
  ```
  Register the screen's generated `<Name>Component` in the app `config` like any other component. Keep a Flutter import in the story file (e.g. `package:flutter/widgets.dart`) so the generated `Key` reference compiles.
- **Testing — snapshot the screen in the golden test at its device viewport, and at the *narrowest* device you support.** Register the screen's generated `<Name>Component` in the golden test's `components` list like any other component (register in BOTH places — see the golden-registration mistake below). A full `Scaffold` won't fit the small component surface, so size the golden harness's root `SizedBox` to phone-portrait (e.g. `Size(390, 844)`); a too-small surface is the only reason to ever exclude a screen — enlarge it instead of dropping the snapshot. The golden `Config` also needs the same `ViewportAddon` (listing every device your screen stories pin) as `widgetbook.config.dart`, or the `ViewportMode` throws `Modes [ViewportMode] do not have a corresponding addon in config`.

  A `RenderFlex` overflow hides at a comfortable width and only bites at the smallest one, so give every screen a **narrowest-supported-device story** (iPhone SE, 375px) next to its default device — that snapshot is what actually catches the overflow. A screen that lays out fine at 390px can overflow by a few pixels at 375px:
  ```dart
  final $Home = _Story(name: 'Home', modes: [ViewportMode(IosViewports.iPhone13ProMax)]);
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
  A plain `flutter_test` widget test that pumps the screen and asserts key content (`find.text(...)`, theme colours) is still worth keeping for semantics — but it is **not** a substitute: a single-width smoke test that only checks text presence sails straight past a small overflow.

Everything else in the feedback loop is the same: regenerate, run `flutter test` until green, and compare the rendered screen against its Figma frame node. After adding or changing a screen, actually open its snapshots under `widgetbook/build/.widgetbook/<Screen>/…` and look — under `flutter test` text renders as filled Ahem boxes, so the snapshot verifies layout, spacing, sizing, and overflow, not glyphs.

## Always do

1. Run `grep -rE "= Meta\(" . --include="*.stories.dart" --exclude-dir=build` to list components.
2. Read the story files relevant to the task.
3. Use design-system widgets, never raw Material (no `ElevatedButton` when `AppButton` exists).
4. Put the story in `widgetbook/lib/` (never `lib/`), immediately after writing the widget.
5. Add one `$Story` per meaningful state (browsable), a `meetsGuideline` scenario for interactive widgets, and register the component in BOTH the app config and the golden test.
6. Catalogue full **screens** too, not just leaf components: a story under `path: 'Screens'` at your default device **and** a second story at the narrowest device you support (iPhone SE, 375px), both registered in the golden test so each gets snapshot-tested for overflow. Keep a widget smoke test for content/semantics. See "Screens are widgets too".
7. Run the feedback loop above to convergence.
8. Only then open a PR.

## Top mistakes

- **Encoding browsable states as `scenarios`.** Scenarios only render under `flutter test`; the running app shows one render per `$Story`. Use one `$Story` per state. See `reference/component-stories.md`.
- **Registering a component in only one place.** It must be in both the app `config` and the golden test's `components`, or its stories silently don't run (no error — the test count just doesn't rise).
- **A device `ViewportMode` on a leaf-component story.** It frames a lone button in a phone canvas. Use `Viewports.none` (natural size) and bound the golden test's own root with a `SizedBox`. (Screens are the exception — they *require* a device `ViewportMode`; see "Screens are widgets too".)
- **Leaving a full screen uncatalogued because it's "just a composition."** A screen is a widget in `lib/` — give it a story (`path: 'Screens'`, a device `ViewportMode`, a widget smoke test). If you built a screen and only catalogued its sub-components, you're not done.
- **Snapshotting a screen at only one comfortable width.** Overflow hides at 390px and bites at 375px (iPhone SE). Give every screen a narrowest-device story and put it in the golden test — a single-width smoke test that only asserts text presence sails past an 11px `RenderFlex` overflow.
- Widgetbook or a `*.stories.dart` placed inside `lib`. It belongs in the `widgetbook/` package.
- `Meta<Widget>()` (old) instead of `Meta(Widget.new)`. Move any `name`, `path`, or `docsBuilder` to a `ComponentMeta`.
- Wrapping values in `StringArg` or `BoolArg` inside `_Args.fixed(...)`; that form takes raw values.
- Hardcoded colors or spacing instead of design tokens.

Full mistakes list with rationale: `reference/api-reference.md`.
