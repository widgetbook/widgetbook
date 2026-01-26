# Widgetbook Story Generation Instructions

Generate comprehensive Widgetbook stories for Flutter components that showcase different variants and configurations effectively.

## Core Requirements

### Meta and Story Structure

Each component must have a `Meta` declaration and stories defined as top-level variables:

```dart
import 'package:widgetbook/widgetbook.dart';

part 'component_name.stories.g.dart';

const meta = Meta<ComponentType>(
  docs: '''
Optional **Markdown** documentation for your component here.
''',
);
```

**Story Naming Rules:**

- Single story: `final $Default = _Story();`
- Multiple stories: Use descriptive names like `$Primary`, `$Disabled`, `$Loading`
- Stories must start with `$` and be declared as top-level variables
- Story names must be unique within the same component

### Story Structure Requirements

**Basic story pattern:**

```dart
final $Default = _Story(
  name: 'Default',  // Optional: Display name for the story
  args: _Args(
    // Type-safe args based on widget constructor
  ),
);
```

**Story conventions:**

- Use `_Story` constructor for story definitions
- Use `_Args` for type-safe parameter configuration
- All stories are automatically built and rendered by the generated code

## Parameter Configuration Strategy

### Priority System

1. **Critical parameters** (required, affects core functionality): Always use Args
2. **Visual parameters** (colors, sizes, styles): Use Args when they demonstrate component flexibility
3. **Behavioral parameters** (enabled/disabled, loading states): Use Args for interactive demonstration
4. **Callback parameters**: Implement with descriptive print statements
5. **Complex objects**: Use static values or custom Args classes with meaningful defaults

### Args Selection Logic

- **Numeric values**: Use DoubleArg and IntArg for input fields
- **Enums**: Use EnumArg for enum types
- **Object selection from predefined options**: Use SingleArg for selecting one object from a list
- **Iterable types (List, Set, etc.)**: Use IterableArg
- **Text content**: Use StringArg
- **Feature toggles**: Use BoolArg

## Comprehensive Args API

### Basic Types

```dart
// Strings
StringArg('Hello World')
StringArg.nullable(null)

// Booleans
BoolArg(true)
BoolArg.nullable(null)

// Integers
IntArg(5)
IntArg.nullable(null)

// Doubles
DoubleArg(1.5)
DoubleArg.nullable(null)
```

### Advanced Types

```dart
// Object selection from predefined options
SingleArg<TextAlign>(
  TextAlign.center,
  values: [TextAlign.left, TextAlign.center, TextAlign.right],
)

// Iterable types (List, Set, etc.)
IterableArg<String>(
  ['Item 1', 'Item 2'],
  // Configure as needed for the specific iterable type
)

// Colors
ColorArg(Colors.blue)
ColorArg.nullable(null)

// DateTime
DateTimeArg(DateTime.now())

// Duration
DurationArg(const Duration(milliseconds: 300))

// Enums
EnumArg<ButtonSize>(
  ButtonSize.medium,
  values: ButtonSize.values,
)
```

## Advanced Component Handling

### State Management Integration

For components requiring external state:

```dart
// Example: Component requiring a provider
final $WithData = _Story(
  name: 'With Data',
  wrapper: (child) => MockDataProvider(
    data: _generateMockData(),
    child: child,
  ),
  args: _Args(
    onItemSelected: CallbackArg<Item>((item) => print('Selected item: ${item.id}')),
    showLoading: BoolArg(false),
  ),
);
```

### Complex Parameter Handling

```dart
// For custom Args classes
class CustomButtonArgs extends Args {
  final StringArg label;
  final BoolArg isEnabled;
  final CustomConfiguration config;

  CustomButtonArgs({
    required this.label,
    required this.isEnabled,
    required this.config,
  });
}

// For unmappable parameters, use static values
final customConfig = CustomConfiguration(
  apiEndpoint: 'https://api.example.com',
  timeout: const Duration(seconds: 30),
);

final $WithCustomConfig = _Story(
  name: 'With Custom Config',
  args: CustomButtonArgs(
    label: StringArg('Custom Button'),
    isEnabled: BoolArg(true),
    config: customConfig,
  ),
);
```

### Callback Implementation Patterns

```dart
// Simple callbacks
onPressed: () => print('Button pressed'),

// Callbacks with data
onChanged: (value) => print('Value changed to: $value'),

// Complex callbacks
onFormSubmitted: (formData) {
  print('Form submitted with data:');
  print('  - Name: ${formData.name}');
  print('  - Email: ${formData.email}');
},

// Async callbacks
onSave: () async {
  print('Save operation started');
  await Future.delayed(const Duration(seconds: 1));
  print('Save operation completed');
},
```

// Callbacks with data
onChanged: (value) => print('Value changed to: $value'),

// Complex callbacks
onFormSubmitted: (formData) {
  print('Form submitted with data:');
  print('  - Name: ${formData.name}');
  print('  - Email: ${formData.email}');
},

// Async callbacks
onSave: () async {
  print('Save operation started');
  await Future.delayed(const Duration(seconds: 1));
  print('Save operation completed');
},
```

### Theme handling

Themes are globally configured in the Config and must not be provided at the story level.

## Story Variant Strategies

### Single Component, Multiple Stories

Create stories that showcase different states and configurations:

```dart
// Default state
final $Default = _Story(
  name: 'Default',
  args: _Args(
    label: StringArg('Click Me'),
    isEnabled: BoolArg(true),
  ),
);

// Loading state
final $Loading = _Story(
  name: 'Loading',
  args: _Args(
    label: StringArg('Loading...'),
    isLoading: BoolArg(true),
    isEnabled: BoolArg(false),
  ),
);

// Disabled state
final $Disabled = _Story(
  name: 'Disabled',
  args: _Args(
    label: StringArg('Disabled'),
    isEnabled: BoolArg(false),
  ),
);

// With icon
final $WithIcon = _Story(
  name: 'With Icon',
  args: _Args(
    label: StringArg('Save'),
    icon: IconArg(Icons.save),
    isEnabled: BoolArg(true),
  ),
);
```

### Responsive and Theme Variants with Scenarios

```dart
final $Responsive = _Story(
  name: 'Responsive',
  scenarios: [
    _Scenario(
      name: 'Small',
      modes: [ViewportMode.mobile],
      args: _Args.fixed(
        size: EnumArg(ProfileSize.small, values: ProfileSize.values),
      ),
    ),
    _Scenario(
      name: 'Medium',
      modes: [ViewportMode.tablet],
      args: _Args.fixed(
        size: EnumArg(ProfileSize.medium, values: ProfileSize.values),
      ),
    ),
    _Scenario(
      name: 'Large',
      modes: [ViewportMode.desktop],
      args: _Args.fixed(
        size: EnumArg(ProfileSize.large, values: ProfileSize.values),
      ),
    ),
  ],
);
```

## Quality Standards

### Code Quality

- **No descriptive comments**: Code should be self-documenting
- **Consistent formatting**: Follow Dart style guidelines
- **Meaningful defaults**: Initial values should represent realistic usage
- **Error handling**: Wrap potentially failing operations in try-catch where appropriate

### Story Coverage

Ensure stories demonstrate:

- [ ] Default/primary functionality
- [ ] Edge cases (empty states, maximum values)
- [ ] Interactive behaviors (hover, focus, disabled states)
- [ ] Visual variants (different styles, sizes, colors)
- [ ] Error states when applicable

### Scenarios and Testing Considerations

```dart
// Include scenarios for golden testing
final $Interactive = _Story(
  name: 'Interactive',
  scenarios: [
    _Scenario(
      name: 'Default State',
      args: _Args.fixed(
        items: IterableArg<String>(
          List.generate(50, (index) => 'Item ${index + 1}'),
        ),
      ),
    ),
    _Scenario(
      name: 'Boundary Test',
      args: _Args.fixed(
        progress: DoubleArg(0.7),
      ),
      run: (tester, args) async {
        // Test interactions
        await tester.tap(find.byType(CustomButton));
        await tester.pumpAndSettle();
        
        // Verify behavior
        expect(find.text('Updated'), findsOneWidget);
      },
    ),
  ],
);
```

## Complete Example Template

```dart
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

part 'custom_slider.stories.g.dart';

const meta = Meta<CustomSlider>(
  docs: '''
A custom slider widget with enhanced functionality.
Supports different themes, sizes, and interaction modes.
''',
);

final $Interactive = _Story(
  name: 'Interactive',
  args: _Args(
    value: DoubleArg(0.5),
    min: DoubleArg(0.0),
    max: DoubleArg(1.0),
    enabled: BoolArg(true),
    showLabels: BoolArg(true),
    activeColor: ColorArg(Colors.blue),
    onChanged: (value) => print('Slider value changed to: $value'),
    onChangeStart: (value) => print('Slider interaction started at: $value'),
    onChangeEnd: (value) => print('Slider interaction ended at: $value'),
  ),
);

final $Disabled = _Story(
  name: 'Disabled',
  args: _Args(
    value: DoubleArg(0.3),
    enabled: BoolArg(false),
    showLabels: BoolArg(true),
  ),
);

final $WithScenarios = _Story(
  name: 'With Scenarios',
  scenarios: [
    _Scenario(
      name: 'Minimum Value',
      args: _Args.fixed(
        value: DoubleArg(0.0),
        enabled: BoolArg(true),
      ),
    ),
    _Scenario(
      name: 'Maximum Value',
      args: _Args.fixed(
        value: DoubleArg(1.0),
        enabled: BoolArg(true),
      ),
      run: (tester, args) async {
        // Test that slider shows maximum value
        expect(find.text('1.0'), findsOneWidget);
      },
    ),
  ],
);
```

## Pre-Generation Checklist

Before generating stories, verify:

- [ ] Component class name and import path
- [ ] Required vs optional parameters
- [ ] Parameter types and constraints
- [ ] Available enum values for EnumArg
- [ ] Asset dependencies and paths
- [ ] State management requirements
- [ ] Theme/localization dependencies
- [ ] Callback signatures and expected behavior
- [ ] Need for custom Args classes for complex parameters
- [ ] Scenarios for golden testing and interaction testing
