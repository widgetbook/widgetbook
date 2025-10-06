import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:nested/nested.dart';

@internal
extension EnumByNameOrNull<T extends Enum> on Iterable<T> {
  /// Finds the enum value in this list with name [name].
  /// Returns `null` if no enum value with that name is found.
  T? byNameOrNull(String name) {
    try {
      return byName(name);
    } catch (e) {
      return null;
    }
  }
}

@internal
class NestedBuilder<T> extends StatelessWidget {
  const NestedBuilder({
    super.key,
    required this.items,
    required this.builder,
    required this.child,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item, Widget child) builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return child;

    final children =
        items
            .map(
              (item) => SingleChildBuilder(
                builder: (context, child) => builder(context, item, child!),
              ),
            )
            .toList();

    return Nested(
      children: children,
      child: child,
    );
  }
}
