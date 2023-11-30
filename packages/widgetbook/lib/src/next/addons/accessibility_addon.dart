import 'package:accessibility_tools/accessibility_tools.dart';

import 'base/builder_addon.dart';

class AccessibilityAddon extends BuilderAddon {
  AccessibilityAddon()
      : super(
          name: 'Accessibility',
          builder: (context, child) => AccessibilityTools(
            child: child,
          ),
        );
}
