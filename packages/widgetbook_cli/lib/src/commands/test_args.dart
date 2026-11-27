import '../test/selection.dart';

final class TestArgs {
  const TestArgs({
    required this.components,
    required this.filters,
    required this.snapshots,
    required this.buildRunner,
    required this.target,
    required this.flutterArgs,
  });

  /// The components of each stories file selected via `--path`.
  final Map<String, Set<String>> components;

  /// The scenarios selected via `--filter`.
  final List<Selection> filters;

  /// Whether the scenarios write their snapshots.
  final bool snapshots;

  /// Whether `build_runner build` runs before the tests.
  final bool buildRunner;

  /// The test file that calls `testWidgetbook`.
  final String target;

  /// The arguments passed to `flutter test` unchanged.
  final List<String> flutterArgs;

  /// Every selection, from both `--path` and `--filter`.
  List<Selection> get selections {
    return [
      for (final names in components.values) ...names.map(Selection.component),
      ...filters,
    ];
  }

  /// A description of each selection for error messages, e.g.
  /// `Component "Counter" (lib/counter.stories.dart)`.
  List<String> get descriptions {
    return [
      for (final MapEntry(key: file, value: names) in components.entries)
        for (final name in names) 'Component "$name" ($file)',
      for (final filter in filters) '"$filter"',
    ];
  }
}
