import 'package:mason_logger/mason_logger.dart';

import '../core/cli_exception.dart';

/// A selection of scenarios by their component, story and scenario names,
/// e.g. `Counter`, `Counter/Default` or `Counter/Default/Loading • Dark`.
///
/// Each level matches a whole name; `*` matches any name at that level.
class Selection {
  const Selection(this.levels)
    : assert(levels.length > 0 && levels.length <= 3, 'Invalid levels');

  /// Parses a `--filter` value such as `Counter/Default`.
  factory Selection.parse(String filter) {
    final levels = filter.split('/');
    if (levels.length > 3 || levels.any((level) => level.trim().isEmpty)) {
      throw CliException(
        'Invalid filter "$filter". '
        'Expected Component, Component/Story or Component/Story/Scenario.',
        ExitCode.usage.code,
      );
    }

    return Selection(levels);
  }

  /// A selection of every scenario of the [component].
  factory Selection.component(String component) {
    return Selection([component]);
  }

  static const wildcard = '*';

  /// The component, story and scenario names, in that order.
  /// Trailing levels are omitted when they are not selected.
  final List<String> levels;

  /// A regex that matches the test names of the selected scenarios.
  ///
  /// Test names are `"<Component> <Story> <Scenario>"`, so a partial selection
  /// ends with a space and a full one with the end of the name.
  String get pattern {
    final names = levels
        .map((level) => level == wildcard ? '.+' : RegExp.escape(level))
        .join(' ');

    return levels.length == 3 ? '$names\$' : '$names ';
  }

  @override
  String toString() => levels.join('/');

  @override
  bool operator ==(Object other) {
    return other is Selection && other.toString() == toString();
  }

  @override
  int get hashCode => toString().hashCode;
}

/// Combines the [selections] into a single anchored regex for
/// `flutter test --name`, as repeated `--name` flags are ANDed.
///
/// Returns `null` when nothing is selected, i.e. every scenario runs.
String? buildNameRegex(Iterable<Selection> selections) {
  final patterns = selections.map((selection) => selection.pattern).toSet();
  if (patterns.isEmpty) return null;
  if (patterns.length == 1) return '^${patterns.single}';

  return '^(?:${patterns.join('|')})';
}
