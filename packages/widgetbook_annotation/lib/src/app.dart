import 'addons_configs.dart';

/// Annotates a code element to create the widgetbook main file in the same
/// folder in which the annotated element is defined.
class App {
  const App({
    this.cloudAddonsConfigs,
  });

  /// {@macro cloud_addons_configs}
  final AddonsConfigs? cloudAddonsConfigs;
}
