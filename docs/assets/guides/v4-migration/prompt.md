# Widgetbook v3 to v4 Migration Guide

You are helping a user migrate their Widgetbook project from v3 to v4. Follow these rules strictly.

---

## 1. Dependencies

Update `pubspec.yaml`:

- **Remove**: `widgetbook_annotation` and `widgetbook_generator`
- **Update**: `widgetbook` to `^4.0.0-alpha.5` or later

---

## 2. Configuration

### 2.1 Entry Point

**v3:**
```dart
void main() {
  runApp(const WidgetbookApp());
}
```

**v4:**
```dart
void main() => runWidgetbook(config);
```

### 2.2 Config Structure

**v3:**
```dart
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

**v4:**
```dart
final config = Config(
  components: components,
  appBuilder: ...,
  addons: [...],
);
```

### 2.3 Theme Addon

**v3:**
```dart
ThemeAddon(
  themes: [
    WidgetbookTheme(name: 'Light', data: AppThemeData.light),
    WidgetbookTheme(name: 'Dark', data: AppThemeData.dark),
  ],
  themeBuilder: (context, theme, child) => AppTheme(data: theme, child: child),
)
```

**v4:**
```dart
ThemeAddon<AppThemeData>(
  {
    'Light': AppThemeData.light,
    'Dark': AppThemeData.dark,
  },
  (context, theme, child) => AppTheme(data: theme, child: child),
)
```

### 2.4 Locale Addon

**v3:**
```dart
LocalizationAddon(
  locales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  initialLocale: AppLocalizations.supportedLocales.last,
)
```

**v4:**
```dart
LocaleAddon(
  AppLocalizations.supportedLocales,
  AppLocalizations.localizationsDelegates,
)
```

### 2.5 Cloud Addons Config → Scenarios

**v3:**
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

**v4:**
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

---

## 3. Stories

### 3.1 Key Changes

| v3 | v4 |
|---|---|
| "Use-case" | "Story" |
| `*.dart` | `*.stories.dart` |
| `@UseCase` annotation | `Meta` + `_Story` |
| `context.knobs.*` | `*Arg` classes |
| `cloudKnobsConfigs` | `scenarios` |

### 3.2 Simple Story

**v3:**
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

**v4:**
```dart
// button.stories.dart
part 'button.stories.book.dart';

const meta = Meta<Button>();

final $Default = _Story(
  designLink: 'https://www.figma.com/...',
  args: _Args(
    content: StringArg('Button'),
  ),
);
```

### 3.3 Custom Args (Knob Name ≠ Parameter Name)

Use `MetaWithArgs` when knob names don't match widget parameters.

**v3:**
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

**v4:**
```dart
// card.stories.dart
part 'card.stories.book.dart';

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

### 3.4 Story-Level Scenarios (replaces `cloudKnobsConfigs`)

**v3:**
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

**v4:**
```dart
// divider.stories.dart
const meta = Meta<Divider>();

final $Default = _Story(
  args: _Args(stroke: DoubleArg(1)),
  scenarios: [
    _Scenario(name: 'Thick', args: _Args(stroke: DoubleArg(10))),
    _Scenario(name: 'Thin', args: _Args(stroke: DoubleArg(0.5))),
  ],
);
```

### 3.5 Mocking with Setup

Move wrapper logic from the use-case body to `setup`.

**v3:**
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

**v4:**
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

---

## 4. Knob to Arg Mapping

| v3 Knob | v4 Arg |
|---|---|
| `context.knobs.string(label: 'x', initialValue: 'y')` | `StringArg('y')` |
| `context.knobs.boolean(label: 'x', initialValue: y)` | `BooleanArg(y)` |
| `context.knobs.int.slider(label: 'x', initialValue: y)` | `IntArg(y)` |
| `context.knobs.double.slider(label: 'x', initialValue: y)` | `DoubleArg(y)` |
| `context.knobs.list(label: 'x', options: [...])` | `ListArg([...])` |

---

## 5. Test File

Create a test file to run golden tests:

```dart
// test/widgetbook_test.dart
import 'package:widgetbook_workspace/widgetbook.config.dart';
import 'package:widgetbook/test.dart';

Future<void> main() async {
  await testWidgetbook(config);
}
```
