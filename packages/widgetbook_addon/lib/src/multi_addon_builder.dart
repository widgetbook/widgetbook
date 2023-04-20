import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import 'widgetbook_addon.dart';
import 'widgetbook_addon_model.dart';

typedef AddonBuilder = Widget Function(
  BuildContext context,
  WidgetbookAddOn addon,
  Widget child,
);

/// Nests [WidgetbookAddOn] builders inside each other, using [Nested] widget.
class MultiAddonBuilder extends StatelessWidget {
  MultiAddonBuilder({
    super.key,
    required this.addons,
    required this.builder,
    this.onChanged,
    required this.child,
  }) {
    if (onChanged == null) return;

    addons.forEach((addon) {
      addon.addListener(onChanged!);
    });
  }

  final List<WidgetbookAddOn> addons;
  final AddonBuilder builder;
  final ValueChanged<WidgetbookAddOnModel>? onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return addons.isEmpty
        ? child
        : Nested(
            children: addons
                .map(
                  (addon) => SingleChildBuilder(
                    builder: (context, child) => builder(
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
