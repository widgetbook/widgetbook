NavPathMode parseNavPathMode(String value) {
  switch (value) {
    case 'component':
      return NavPathMode.component;
    case 'use-case':
      return NavPathMode.useCase;
    default:
      throw ArgumentError(
        'Unknown NavPathMode: $value. '
        'Use either "component" or "use-case"',
      );
  }
}

enum NavPathMode {
  /// Determines the navigation path based on where the widget type
  /// is located. Used to reflect the folder structure of your app.
  /// This is the default mode.
  ///
  /// For example, the `navPath` for the following use-case
  /// would be `widgets/PrimaryButton/Default`:
  ///
  /// ```dart
  /// // widgetbook/lib/buttons/primary_button.dart
  /// import 'package:my_app/widgets/primary_button.dart';
  ///
  /// @UseCase(name: 'Default', type: PrimaryButton)
  /// Widget primaryButtonUseCase(Build Context) { ... }
  /// ```
  component,

  /// Determines the navigation path based on where the use-case annotation
  /// is used. Used to reflect the folder structure of your widgetbook app.
  ///
  /// For example, the `navPath` for the following use-case
  /// would be `buttons/PrimaryButton/Default`:
  ///
  /// ```dart
  /// // widgetbook/lib/buttons/primary_button.dart
  /// import 'package:my_app/widgets/primary_button.dart';
  ///
  /// @UseCase(name: 'Default', type: PrimaryButton)
  /// Widget primaryButtonUseCase(Build Context) { ... }
  /// ```
  useCase,
}
