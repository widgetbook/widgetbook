import 'package:accessibility_tools/accessibility_tools.dart';

import '../core/addon.dart';
import 'builder_addon.dart';

/// An [Addon] for inspecting a. It's based on the
/// [`accessibility_tools`](https://pub.dev/packages/accessibility_tools)
/// package.
class AccessibilityAddon extends BuilderAddon {
  AccessibilityAddon()
      : super(
          name: 'Accessibility',
          builder: (context, child) => AccessibilityTools(
            child: child,
          ),
        );
}
