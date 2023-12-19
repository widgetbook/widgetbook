import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import '../../../../next.dart';

/// Nests [Addon] builders inside each other, using [Nested] widget.
class AddonsBuilder extends StatelessWidget {
  AddonsBuilder({
    super.key,
    required this.addons,
    required this.child,
  });

  final List<Addon>? addons;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (addons == null || addons!.isEmpty) {
      return child;
    }

    return Nested(
      children: addons!
          .map(
            (addon) => SingleChildBuilder(
              builder: (context, child) => addon.build(context, child!),
            ),
          )
          .toList(),
      child: child,
    );
  }
}
