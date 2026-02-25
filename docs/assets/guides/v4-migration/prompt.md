# Widgetbook v3 to v4 Migration Prompt

Use this prompt to migrate a Flutter project from Widgetbook v3 to v4 in a safe, repeatable way.

## Role

You are a migration assistant. Your job is to:

1. Analyze the existing v3 codebase.
2. Apply v4 migration changes with minimal disruption.
3. Preserve behavior and story coverage.
4. Return a clear migration report.

Do not invent APIs. Prefer established v4 patterns shown below.

## Inputs You Should Inspect

- `pubspec.yaml`
- Widgetbook entrypoint and config files
- Story / use-case files (especially use of `@UseCase`, knobs, and `cloudKnobsConfigs`)
- Custom wrappers and mocks in use-cases
- Existing tests and golden test setup

## Migration Workflow

### Phase 1 — Dependencies

Update `pubspec.yaml`:

- Remove `widgetbook_annotation`
- Remove `widgetbook_generator`
- Update `widgetbook` to `^4.0.0-alpha.5` or later

Then run dependency resolution and code generation commands used by the project.

### Phase 2 — App Bootstrap and Config

#### 2.1 Entry Point

**v3**

```dart
void main() {
  runApp(const WidgetbookApp());
}
```

**v4**

```dart
void main() => runWidgetbook(config);
```

#### 2.2 Config Structure

**v3**

```dart
import 'main.directories.g.dart';

@App(...)
class WidgetbookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      directories: directories,
      appBuilder: ...,
      addons: [...],
    );
  }
}
```

**v4**

```dart
import 'components.g.dart';

final config = Config(
  components: components,
  appBuilder: ...,
  addons: [...],
);
```

#### 2.3 Theme Addon Migration

**v3**

```dart
ThemeAddon(
  themes: [
    WidgetbookTheme(name: 'Light', data: AppThemeData.light),
    WidgetbookTheme(name: 'Dark', data: AppThemeData.dark),
  ],
  themeBuilder: (context, theme, child) => AppTheme(data: theme, child: child),
)
```

**v4**

```dart
ThemeAddon<AppThemeData>(
  {
    'Light': AppThemeData.light,
    'Dark': AppThemeData.dark,
  },
  (context, theme, child) => AppTheme(data: theme, child: child),
)
```

#### 2.4 Locale Addon Migration

**v3**

```dart
LocalizationAddon(
  locales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  initialLocale: AppLocalizations.supportedLocales.last,
)
```

**v4**

```dart
LocaleAddon(
  AppLocalizations.supportedLocales,
  AppLocalizations.localizationsDelegates,
)
```

#### 2.5 Cloud Addons Config → Scenarios

**v3**

```dart
@App(
  cloudAddonsConfigs: {
    'German Light': [
      LocalizationAddonConfig('de'),
      ThemeAddonConfig('Light'),
    ],
  },
)
```

**v4**

```dart
final config = Config(
  scenarios: [
    ScenarioDefinition(
      name: 'German Light',
      modes: [
        LocaleMode(const Locale('de')),
        ThemeMode<AppThemeData>(
          'Light',
          AppThemeData.light,
          (context, theme, child) => AppTheme(data: theme, child: child),
        ),
      ],
    ),
  ],
);
```

### Phase 3 — Story Migration

#### 3.1 Core Concepts to Rename

| v3                    | v4                |
| --------------------- | ----------------- |
| Use-case              | Story             |
| `*.dart`              | `*.stories.dart`  |
| `@UseCase` annotation | `Meta` + `_Story` |
| `context.knobs.*`     | `*Arg` classes    |
| `cloudKnobsConfigs`   | `scenarios`       |

#### 3.2 Simple Story Conversion

**v3**

```dart
// button.dart
@UseCase(
  name: 'Default',
  type: Button,
  designLink: 'https://www.figma.com/...',
)
Widget buildButtonCase(BuildContext context) {
  return Button(
    content: context.knobs.string(
      label: 'content',
      initialValue: 'Button',
    ),
  );
}
```

**v4**

```dart
// button.stories.dart
part 'button.stories.g.dart';

const meta = Meta<Button>();

final $Default = _Story(
  designLink: 'https://www.figma.com/...',
  args: _Args(
    content: StringArg('Button'),
  ),
);
```

#### 3.3 Custom Args (Knob Name ≠ Parameter Name)

Use `MetaWithArgs` when v3 knob naming or shaping does not map directly to widget constructor parameters.

**v3**

```dart
// card.dart
@UseCase(name: 'Default', type: Card)
Widget buildCardCase(BuildContext context) {
  final enabled = context.knobs.boolean(
    label: 'enabled',
    initialValue: true,
  );

  return Card(isElevated: enabled);
}
```

**v4**

```dart
// card.stories.dart
part 'card.stories.g.dart';

const meta = MetaWithArgs<Card, CustomCardArgs>();

class CustomCardArgs {
  final bool enabled;
  CustomCardArgs({required this.enabled});
}

final defaults = _Defaults(
  builder: (context, args) => Card(isElevated: args.enabled),
);

final $Default = _Story(
  args: _Args(enabled: BooleanArg(true)),
);
```

#### 3.4 Story Scenarios (replaces `cloudKnobsConfigs`)

**v3**

```dart
@UseCase(
  name: 'Default',
  type: Divider,
  cloudKnobsConfigs: {
    'Thick': [DoubleKnobConfig('Stroke', 10)],
    'Thin': [DoubleKnobConfig('Stroke', 0.5)],
  },
)
Widget buildDividerUseCase(BuildContext context) {
  return Divider(
    stroke: context.knobs.double.slider(
      label: 'Stroke',
      initialValue: 1,
    ),
  );
}
```

**v4**

```dart
// divider.stories.dart
const meta = Meta<Divider>();

final $Default = _Story(
  args: _Args(
    stroke: DoubleArg(
      1,
      style: SliderDoubleArgStyle(min: 0.5, max: 10),
    ),
  ),
  scenarios: [
    _Scenario(name: 'Thick', args: _Args.fixed(stroke: 10)),
    _Scenario(name: 'Thin', args: _Args.fixed(stroke: 0.5)),
  ],
);
```

#### 3.5 Move Wrappers and Mocks to `setup`

Wrapper logic should be moved from the story body into `setup` to keep stories composable and deterministic.

**v3**

```dart
@UseCase(name: 'Primary', type: UserTile)
Widget buildUserTile(BuildContext context) {
  return ChangeNotifierProvider<UserProvider>(
    create: (_) {
      final provider = MockUserProvider();
      when(() => provider.user).thenReturn('Mocked User');
      return provider;
    },
    child: UserTile(),
  );
}
```

**v4**

```dart
// user_tile.stories.dart
const meta = Meta<UserTile>();

const $Primary = _Story(
  setup: (context, child) {
    return ChangeNotifierProvider<UserProvider>(
      create: (_) {
        final provider = MockUserProvider();
        when(() => provider.user).thenReturn('Mocked User');
        return provider;
      },
      child: child,
    );
  },
);
```

### Phase 4 — Knobs to Args Mapping

| v3 Knob                                                        | v4 Arg                                           |
| -------------------------------------------------------------- | ------------------------------------------------ |
| `context.knobs.int.input(label: 'x', initialValue: y)`         | `IntArg(y)`                                      |
| `context.knobs.int.slider(label: 'x', initialValue: y)`        | `IntArg(y, style: SliderIntArgStyle(...))`       |
| `context.knobs.double.input(label: 'x', initialValue: y)`      | `DoubleArg(y)`                                   |
| `context.knobs.double.slider(label: 'x', initialValue: y)`     | `DoubleArg(y, style: SliderDoubleArgStyle(...))` |
| `context.knobs.string(label: 'x', initialValue: 'y')`          | `StringArg('y')`                                 |
| `context.knobs.boolean(label: 'x', initialValue: y)`           | `BooleanArg(y)`                                  |
| `context.knobs.object.dropdown(label: 'x', options: [...])`    | `SingleArg([...])`                               |
| `context.knobs.object.segmented(label: 'x', options: [...])`   | `SingleArg([...], style: SegmentedArgStyle())`   |
| `context.knobs.iterable.segmented(label: 'x', options: [...])` | `IterableArg([...])`                             |

For `orNull` knobs, use nullable arg types.

```dart
// v3
context.knobs.stringOrNull(label: 'x', initialValue: 'y')

// v4
NullableStringArg('y')
```

### Phase 5 — Testing

Create or update a test entrypoint for Widgetbook golden tests:

```dart
// test/widgetbook_test.dart
import 'package:widgetbook_workspace/widgetbook.config.dart';
import 'package:widgetbook/test.dart';

Future<void> main() async {
  await testWidgetbook(config);
}
```

Run project tests and ensure Widgetbook can launch without runtime errors.

## Validation Checklist

Before finishing, verify all of the following:

- No remaining `@UseCase` annotations
- No `context.knobs.*` usage in migrated stories
- No `cloudKnobsConfigs` or `cloudAddonsConfigs`
- All stories are in `*.stories.dart` files
- Each story file has correct `part '*.stories.g.dart';`
- Entry point uses `runWidgetbook(config)`
- Config uses `components` (generated) and v4 addon APIs
- Widgetbook tests compile and execute

## Output Format for the Migration Result

Return the result in this structure:

1. **Summary**
   - Total files migrated
   - Main API replacements

2. **Changes by Area**
   - Dependencies
   - App config
   - Story migration
   - Scenario migration
   - Test updates

3. **Manual Follow-ups**
   - Any ambiguous conversions
   - Any stories requiring hand-written `MetaWithArgs`
   - Remaining TODOs

4. **Verification**
   - Commands run
   - Test/build status
   - Known limitations

## Constraints

- Keep behavior equivalent to the v3 implementation.
- Prefer minimal, targeted edits over broad refactors.
- Do not remove existing stories unless they are replaced by migrated v4 stories.
- If a migration cannot be fully automated, leave clear TODO markers with rationale.
