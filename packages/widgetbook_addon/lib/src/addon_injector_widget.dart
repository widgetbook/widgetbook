import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import 'widgetbook_addon.dart';
import 'widgetbook_addon_model.dart';

class AddonInjectorWidget extends StatelessWidget {
  AddonInjectorWidget({
    required this.addons,
    required this.routerData,
    required this.onChanged,
    required this.child,
    super.key,
  }) {
    addons.forEach(
      (addon) => addon.addListener(onChanged),
    );
  }

  final List<WidgetbookAddOn> addons;
  final Map<String, String> routerData;
  final ValueChanged<WidgetbookAddOnModel> onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return addons.isEmpty
        ? child
        : Nested(
            key: ValueKey(routerData),
            children: [
              ...addons.map(
                (e) => SingleChildBuilder(
                  builder: (context, child) => e.buildProvider(
                    routerData,
                    child!,
                  ),
                ),
              ),
            ],
            child: child,
          );
  }
}
