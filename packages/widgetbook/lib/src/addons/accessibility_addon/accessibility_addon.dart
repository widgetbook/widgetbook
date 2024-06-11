import 'package:accessibility_tools/accessibility_tools.dart';
import '../builder_addon/builder_addon.dart';

/// A [WidgetbookAddon] for inspecting a. It's based on the
/// [`accessibility_tools`](https://pub.dev/packages/accessibility_tools)
/// package.
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
