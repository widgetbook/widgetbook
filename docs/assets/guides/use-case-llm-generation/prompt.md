# Widgetbook Use-Case Generation Instructions

Generate comprehensive Widgetbook use cases for Flutter components that showcase different variants and configurations effectively.

## Core Requirements

### UseCase Annotation Structure

Each use case must have a properly configured `@UseCase` annotation:

```dart
@UseCase(
  name: 'variantName',    // Required: Unique identifier for this variant
  type: ComponentType,    // Required: The Flutter widget class being showcased
)
```

**Naming Rules:**

- Single use case: `name: 'default'`
- Multiple use cases: Use descriptive names like `'with_label'`, `'disabled'`, `'loading'`
- Names must be unique within the same component type

### Method Signature Requirements

**Exact signature pattern:**

```dart
Widget build[ComponentName][VariantName]UseCase(BuildContext context) {
  // Implementation
}
```

**Naming conventions:**

- Single use case: `buildProgressIndicatorUseCase`
- Multiple use cases: `buildProgressIndicatorWithLabelUseCase`, `buildProgressIndicatorDisabledUseCase`
- Always return `Widget`
- Always accept exactly one parameter: `BuildContext context`

## Parameter Configuration Strategy

### Priority System

1. **Critical parameters** (required, affects core functionality): Always use knobs
2. **Visual parameters** (colors, sizes, styles): Use knobs when they demonstrate component flexibility
3. **Behavioral parameters** (enabled/disabled, loading states): Use knobs for interactive demonstration
4. **Callback parameters**: Implement with descriptive print statements
5. **Complex objects**: Hardcode with meaningful defaults, add TODO comments

### Knob Selection Logic

- **Bounded numeric values**: Use sliders (opacity: 0.0-1.0, progress: 0-100)
- **Unbounded numeric values**: Use input fields (dimensions, counts)
- **Enums/predefined options**: Use list knobs
- **Text content**: Use string inputs
- **Feature toggles**: Use boolean checkboxes

## Comprehensive Knobs API

### Basic Types

```dart
// Strings
context.knobs.string(label: 'text', initialValue: 'Hello World')
context.knobs.stringOrNull(label: 'optionalText', initialValue: null)

// Booleans
context.knobs.boolean(label: 'enabled', initialValue: true)
context.knobs.booleanOrNull(label: 'optionalFlag', initialValue: null)

// Integers
context.knobs.int.input(label: 'count', initialValue: 5)
context.knobs.int.slider(label: 'progress', initialValue: 50, min: 0, max: 100, divisions: 10)
context.knobs.intOrNull.input(label: 'optionalCount', initialValue: null)
context.knobs.intOrNull.slider(label: 'progress', initialValue: null, min: 0, max: 100, divisions: 10)

// Doubles
context.knobs.double.input(label: 'value', initialValue: 1.5)
context.knobs.double.slider(label: 'opacity', initialValue: 0.8, min: 0.0, max: 1.0, divisions: 20)
context.knobs.doubleOrNull.input(label: 'value', initialValue: null)
context.knobs.doubleOrNull.slider(label: 'optionalOpacity', initialValue: null, min: 0.0, max: 1.0)
```

### Advanced Types

```dart
// Dropdown lists
context.knobs.object.dropdown<TextAlign>(
  label: 'textAlign',
  initialOption: TextAlign.center,
  options: [TextAlign.left, TextAlign.center, TextAlign.right],
  labelBuilder: (value) => value.name,
)

// Colors
context.knobs.color(label: 'primaryColor', initialValue: Colors.blue)
context.knobs.colorOrNull(label: 'optionalColor', initialValue: null)

// DateTime
context.knobs.dateTime(
  label: 'selectedDate',
  initialValue: DateTime.now(),
  start: DateTime.now().subtract(const Duration(days: 365)),
  end: DateTime.now().add(const Duration(days: 365)),
)

// Duration
context.knobs.duration(label: 'animationDuration', initialValue: const Duration(milliseconds: 300))
```

## Advanced Component Handling

### State Management Integration

For components requiring external state:

```dart
// Example: Component requiring a provider
@UseCase(name: 'with_data', type: DataWidget)
Widget buildDataWidgetWithDataUseCase(BuildContext context) {
  return MockDataProvider(
    data: _generateMockData(),
    child: DataWidget(
      onItemSelected: (item) => print('Selected item: ${item.id}'),
      showLoading: context.knobs.boolean(label: 'showLoading', initialValue: false),
    ),
  );
}
```

### Complex Parameter Handling

```dart
// For unmappable parameters
final customObject = CustomConfiguration(
  // Hardcoded meaningful defaults
  apiEndpoint: 'https://api.example.com',
  timeout: const Duration(seconds: 30),
); // TODO: User should configure CustomConfiguration manually

// For asset references
final iconPath = 'assets/icons/star.svg'; // Verify asset exists in pubspec.yaml
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

### Theme handling

Themes are globally injected and must not be provided.

## Use Case Variant Strategies

### Single Component, Multiple Variants

Create variants that showcase different states and configurations:

```dart
// Default state
@UseCase(name: 'default', type: CustomButton)
Widget buildCustomButtonUseCase(BuildContext context) { /* ... */ }

// Loading state
@UseCase(name: 'loading', type: CustomButton)
Widget buildCustomButtonLoadingUseCase(BuildContext context) { /* ... */ }

// Disabled state
@UseCase(name: 'disabled', type: CustomButton)
Widget buildCustomButtonDisabledUseCase(BuildContext context) { /* ... */ }

// With icon
@UseCase(name: 'with icon', type: CustomButton)
Widget buildCustomButtonWithIconUseCase(BuildContext context) { /* ... */ }
```

### Responsive and Theme Variants

```dart
// Different sizes
@UseCase(name: 'small', type: ProfileCard)
@UseCase(name: 'medium', type: ProfileCard)
@UseCase(name: 'large', type: ProfileCard)
```

## Quality Standards

### Code Quality

- **No descriptive comments**: Code should be self-documenting
- **Consistent formatting**: Follow Dart style guidelines
- **Meaningful defaults**: Initial values should represent realistic usage
- **Error handling**: Wrap potentially failing operations in try-catch where appropriate

### Use Case Coverage

Ensure use cases demonstrate:

- [ ] Default/primary functionality
- [ ] Edge cases (empty states, maximum values)
- [ ] Interactive behaviors (hover, focus, disabled states)
- [ ] Visual variants (different styles, sizes, colors)
- [ ] Error states when applicable

### Testing Considerations

```dart
// Include realistic data volumes
final items = List.generate(50, (index) => 'Item ${index + 1}');

// Test boundary conditions
final progress = context.knobs.double.slider(
  label: 'progress',
  initialValue: 0.7,
  min: 0.0,
  max: 1.0,
  divisions: 100,
); // Allows testing 0%, 100%, and intermediate values
```

## Complete Example Template

```dart
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'interactive',
  type: CustomSlider,
)
Widget buildCustomSliderInteractiveUseCase(BuildContext context) {
  return CustomSlider(
    value: context.knobs.double.slider(
      label: 'value',
      initialValue: 0.5,
      min: 0.0,
      max: 1.0,
      divisions: 20,
    ),
    min: context.knobs.double.input(
      label: 'min',
      initialValue: 0.0,
    ),
    max: context.knobs.double.input(
      label: 'max',
      initialValue: 1.0,
    ),
    enabled: context.knobs.boolean(
      label: 'enabled',
      initialValue: true,
    ),
    showLabels: context.knobs.boolean(
      label: 'showLabels',
      initialValue: true,
    ),
    activeColor: context.knobs.color(
      label: 'activeColor',
      initialValue: Colors.blue,
    ),
    onChanged: (value) => print('Slider value changed to: $value'),
    onChangeStart: (value) => print('Slider interaction started at: $value'),
    onChangeEnd: (value) => print('Slider interaction ended at: $value'),
  );
}
```

## Pre-Generation Checklist

Before generating use cases, verify:

- [ ] Component class name and import path
- [ ] Required vs optional parameters
- [ ] Parameter types and constraints
- [ ] Available enum values for list knobs
- [ ] Asset dependencies and paths
- [ ] State management requirements
- [ ] Theme/localization dependencies
- [ ] Callback signatures and expected behavior
