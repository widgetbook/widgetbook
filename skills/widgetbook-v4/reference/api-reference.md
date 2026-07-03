# Widgetbook v4 API reference

Full detail behind the essentials in `SKILL.md`. Read the section you need.

## Workspace structure

The Widgetbook workspace is its own Flutter package and lives outside the app's `lib`, as a sibling `widgetbook/` folder. Do not put Widgetbook or story files inside `lib`. This is a deliberate change from v3, where Widgetbook could sit inside `lib`, `test`, or a `widgetbook` folder with no defined convention. v4 fixes a single structure so dependencies, code generation, and builds stay predictable.

```
my_app/
├── lib/               # app code, no Widgetbook here
├── test/
├── widgetbook/        # separate Widgetbook workspace package
│   ├── lib/           # *.stories.dart live here
│   └── pubspec.yaml   # widgetbook_workspace; depends on the app
└── pubspec.yaml       # app; lists widgetbook_workspace as a dev_dependency
```

There is an intentional cyclic dependency: the workspace depends on the app so it can catalogue the app's widgets, and the app depends on the workspace as a dev dependency so tests can reuse stories. Scaffold with `dart pub global activate widgetbook_cli` then `widgetbook init`. Run `dart run build_runner build -d` and `flutter test` from inside `widgetbook/`.

## Meta

`Meta` declares which widget a story file belongs to, using a constructor tear-off. It is the anchor for all generated types in the file. The widget type is inferred from the tear-off, so no type argument is needed. `Meta` must be `const` because the generator resolves the tear-off via constant evaluation.

```dart
import 'package:widgetbook/widgetbook.dart';

part 'app_button.stories.g.dart';

const meta = Meta(AppButton.new);
```

Run `dart run build_runner build -d` inside `widgetbook/` after adding or changing a `Meta`. It generates `_Story`, `_Args`, and `_Scenario` for that widget.

### Multiple constructors per component

A component can catalogue more than one constructor. Declare one `const Meta` per constructor, each targeting the same widget. Named and factory constructors get generated types prefixed with the PascalCase constructor name (`_IconStory`, `_IconArgs`, `_IconScenario`, `_IconDefaults`). Each story is a `$`-prefixed variable; set its display name with `name:`.

```dart
const meta = Meta(AppButton.new);
const iconMeta = Meta(AppButton.icon);

final $Default = _Story(name: 'Default', args: _Args(label: StringArg('Save')));
final $Icon = _IconStory(name: 'Icon', args: _IconArgs(icon: Arg.fixed(Icons.save)));
```

### Component-level customization with `ComponentMeta`

To set a component's `name`, `path`, or `docsBuilder`, declare an optional `ComponentMeta` (at most one per file) alongside the `Meta`. Use `final` when `docsBuilder` holds a closure, otherwise `const`. Do not declare a parameterless `ComponentMeta`.

```dart
final component = ComponentMeta(
  name: 'Card',
  path: '[containers]/card',
  docsBuilder: (blocks) => blocks.replaceFirst<DartCommentDocBlock>(
    const TextDocBlock('A rounded card container.'),
  ),
);

const meta = Meta(CustomCard.new);
```

## Stories

A story is a named variant of a widget:

```dart
final $Default = _Story(name: 'Default');
```

## Args

By default, Args are generated from the widget's constructor, one typed `Arg` per parameter. To generate Args from a custom class instead, pass `argsType:` to `Meta`, for example `Meta(AppButton.new, argsType: AppButtonArgs.new)`. Use this when the constructor is a poor testable interface (complex objects, callbacks, providers, mocking). `argsType` also selects a specific constructor of the args class, e.g. `argsType: AppButtonArgs.compact`.

| Constructor parameter type | Arg type |
|---|---|
| `String` | `StringArg('value')` |
| `bool` | `BoolArg(true)` |
| `int` | `IntArg(0)` |
| `double` | `DoubleArg(0.0)` |
| `enum` | `EnumArg(MyEnum.value)` |
| callbacks / fixed values | `Arg.fixed(value)` |

### `_Args(...)` vs `_Args.fixed(...)`

`_Args(...)` is typed and interactive. Wrap each value in its `Arg` type. These render as knobs in the story viewer. Use it at the story level so people can adjust the widget. Values that should not be interactive use `Arg.fixed(value)`, and callbacks always use `Arg.fixed(() {})`.

```dart
final $Primary = _Story(
  name: 'Primary',
  args: _Args(
    label: StringArg('Confirm'),
    variant: EnumArg(ButtonVariant.primary),
    isEnabled: BoolArg(true),
    onPressed: Arg.fixed(() {}),
  ),
);
```

`_Args.fixed(...)` is raw and non-interactive. Pass plain values with no `Arg` wrappers, and bare closures for callbacks. There are no knobs. This is the usual form inside scenarios, where each scenario pins one configuration to snapshot.

```dart
args: _Args.fixed(label: 'This is a very long label', onPressed: () {}),
```

Inside a scenario's `run` callback, values are still accessed through the arg wrapper, e.g. `args.label.value`.

## Modes

Modes are reusable addon configurations: the exact theme, locale, or viewport to apply when rendering a story.

```dart
final $Button = _Story(
  name: 'Button',
  modes: [
    MaterialThemeMode('Light', ThemeData.light()),
    MaterialThemeMode('Dark', ThemeData.dark()),
  ],
);
```

## Scenarios

Scenarios are story-level test configurations. Each defines a set of args and modes to render and snapshot automatically. They are the v4 equivalent of golden tests, defined next to the story, and typically use `_Args.fixed(...)`.

```dart
final $Primary = _Story(
  name: 'Primary',
  scenarios: [
    _Scenario(name: 'Enabled', args: _Args.fixed(label: 'Click Me', isEnabled: true)),
    _Scenario(
      name: 'Disabled dark',
      modes: [MaterialThemeMode('Dark', ThemeData.dark())],
      args: _Args.fixed(label: 'Click Me', isEnabled: false),
    ),
  ],
);
```

Run with `flutter test`. Snapshots land in `widgetbook/build/.widgetbook`.

### Global scenarios

To apply a scenario configuration to every story (for example, always snapshot a Dark variant), define it once in `widgetbook.config.dart` using `ScenarioDefinition` on `Config.scenarios`:

```dart
final config = Config(
  scenarios: [
    ScenarioDefinition(name: 'Dark', modes: [MaterialThemeMode('Dark', ThemeData.dark())]),
  ],
);
```

Use global scenarios for cross-cutting configurations (themes, locales, text scale). Keep per-story scenarios for widget-specific states (loading, error, expired).

## Interaction testing

Scenarios support a `run` callback for interaction tests. With Widgetbook Cloud these run on every PR.

```dart
_Scenario(
  name: 'Incremented counter',
  run: (tester, args) async {
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('${args.initialValue.value + 1}'), findsOneWidget);
  },
),
```

## Accessibility testing

Because scenarios run under `flutter test`, assert accessibility guidelines in the same pass with Flutter's `meetsGuideline` matchers (from `flutter_test`), inside a scenario's `run`. Wrap the assertions in a semantics handle and dispose it.

```dart
_Scenario(
  name: 'Reject action accessible',
  args: _Args.fixed(label: 'Reject', onPressed: () {}),
  run: (tester, args) async {
    final handle = tester.ensureSemantics();
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  },
),
```

The four matchers cover the common WCAG failures for touch UI: tap target size (Android and iOS), a screen-reader label on every interactive element, and text contrast. On failure the output names the offending node and what it expected, which you can act on directly.

## Component documentation

v4 generates docs from your widgets and stories via `DocBlock`s. Configure globally in `Config` or per-component in `ComponentMeta`. Dart doc comments on the widget class are surfaced automatically via `DartCommentDocBlock`.

```dart
final config = Config(
  components: components,
  docsBuilder: () => [
    const ComponentNameDocBlock(),
    const DartCommentDocBlock(),
    const StoriesDocBlock(),
  ],
);
```

## Story file conventions

- **Location and naming:** story files live in `widgetbook/lib/`, outside the app's `lib`. Name them `my_widget.stories.dart` and mirror the widget's path, e.g. `widgetbook/lib/components/app_button.stories.dart`.
- **Part directive:** always include `part 'my_widget.stories.g.dart';` right after imports.
- **One widget per file:** every `Meta` in a file targets the same widget. One `const Meta` per constructor, at most one `ComponentMeta`.
- **Doc comment on the widget class:** write a Dart doc comment on the class explaining purpose and usage constraints. It becomes the component documentation.
- **Scenario coverage:** cover the states that matter for visual regression (enabled, disabled, loading, error, empty). Use existing stories as the benchmark for thorough.
- **Accessibility coverage:** for interactive components, add at least one scenario asserting the `meetsGuideline` matchers.
- **Callbacks:** in `_Args(...)` use `Arg.fixed(() {})`; in `_Args.fixed(...)` pass a bare `() {}`.

### Complete example

```dart
import 'package:widgetbook/widgetbook.dart';
import 'package:app/components/status_banner.dart';

part 'status_banner.stories.g.dart';

/// Displays an inline status message.
/// Used at the top of forms and list screens.
/// Always set isDismissible: false for blocking errors.
const meta = Meta(StatusBanner.new);

final $Default = _Story(
  name: 'Default',
  scenarios: [
    _Scenario(
      name: 'Info',
      args: _Args.fixed(type: BannerType.info, message: 'Changes saved', isDismissible: true),
    ),
    _Scenario(
      name: 'Success',
      args: _Args.fixed(type: BannerType.success, message: 'Upload complete', isDismissible: true),
    ),
    _Scenario(
      name: 'Error',
      args: _Args.fixed(type: BannerType.error, message: 'Upload failed', isDismissible: false),
    ),
  ],
);
```

## Common mistakes

- **Widgetbook or a story inside `lib`.** It belongs in the `widgetbook/` package.
- **Forgetting the part directive.** Without `part 'my_widget.stories.g.dart';`, build_runner has nowhere to write generated types and the file will not compile.
- **Using raw Material widgets.** Scan the story files first and use the design-system widget.
- **A Default story with no scenarios.** No scenarios means no automated snapshot coverage.
- **Confusing `_Args` and `_Args.fixed`.** `_Args(...)` takes wrapped `Arg` values and produces knobs. `_Args.fixed(...)` takes raw values with no knobs and is the scenario form. Do not wrap values in `StringArg` or `BoolArg` when using `_Args.fixed`.
- **Non-fixed callback arg.** Callbacks cannot be interactive. In `_Args(...)` use `Arg.fixed(() {})`; in `_Args.fixed(...)` pass a bare `() {}`.
- **Skipping accessibility scenarios.** Interactive components should assert `meetsGuideline` so touch-target and labeling regressions are caught in `flutter test`.
- **Not running build_runner after a constructor change.** Adding, renaming, or removing a constructor parameter requires `dart run build_runner build -d` before writing stories, or the generated `_Args` is stale.
- **Using `flutter pub run build_runner`.** Deprecated. Use `dart run build_runner build -d`.
- **The old `Meta<Widget>()` form.** See `reference/migration.md`.
- **Saying "props".** Flutter widgets have constructor parameters, not props.
- **Assuming `_Args` equals the constructor.** With a custom `argsType:`, `_Args` may differ. Read the story file first.
