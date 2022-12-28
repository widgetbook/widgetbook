import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:widgetbook/src/addons/addon.dart';

class AddonInjectorWidget extends StatelessWidget {
  const AddonInjectorWidget({
    super.key,
    required this.addons,
    required this.routerData,
    required this.child,
  });

  final List<WidgetbookAddOn> addons;
  final Widget child;
  final Map<String, dynamic> routerData;

  @override
  Widget build(BuildContext context) {
    return Nested(
      key: ValueKey(routerData),
      children: addons
          .map(
            (e) => SingleChildBuilder(
              builder: (context, child) => e.wrapperBuilder(
                context,
                routerData,
                child!,
              ),
            ),
          )
          .toList(),
      child: child,
    );
  }
}
