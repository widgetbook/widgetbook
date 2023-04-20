import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

class MultiAddonWrapper extends StatelessWidget {
  const MultiAddonWrapper({
    super.key,
    required this.addons,
    required this.child,
  });

  final List<WidgetbookAddOn> addons;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return addons.isEmpty
        ? child
        : Nested(
            children: [
              ...addons.map(
                (addon) => SingleChildBuilder(
                  builder: (context, child) => addon.buildUseCaseWrapper(
                    context,
                    child!,
                  ),
                ),
              ),
            ],
            child: child,
          );
  }
}
