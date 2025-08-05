import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:nested/nested.dart';

import 'widgetbook_addon.dart';

/// @nodoc
@internal
typedef AddonBuilder =
    Widget Function(
      BuildContext context,
      WidgetbookAddon addon,
      Widget child,
    );

/// Nests [WidgetbookAddon] builders inside each other, using [Nested] widget.
@internal
class MultiAddonBuilder extends StatelessWidget {
  MultiAddonBuilder({
    super.key,
    required this.addons,
    required this.builder,
    required this.child,
  });

  final List<WidgetbookAddon>? addons;
  final AddonBuilder builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (addons == null || addons!.isEmpty) {
      return child;
    }

    return Nested(
      children:
          addons!
              .map(
                (addon) => SingleChildBuilder(
                  builder:
                      (context, child) => builder(
                        context,
                        addon,
                        child!,
                      ),
                ),
              )
              .toList(),
      child: child,
    );
  }
}
