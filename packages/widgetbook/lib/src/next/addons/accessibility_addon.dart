import 'package:accessibility_tools/accessibility_tools.dart';

import 'base/builder_addon.dart';

@Deprecated(
  'Please use the `accessibility_tools` package directly with a `BuilderAddon`. '
  'For more information, see https://docs.widgetbook.io/addons/accessibility-addon.',
)
class AccessibilityAddon extends BuilderAddon {
  AccessibilityAddon()
      : super(
          name: 'Accessibility',
          builder: (context, child) => AccessibilityTools(
            child: child,
          ),
        );
}
