import 'package:inspector/inspector.dart';

import 'builder_addon.dart';

class InspectorAddon extends BuilderAddon {
  InspectorAddon()
      : super(
          name: 'Inspector',
          builder: (context, child) {
            return Inspector(
              child: child,
              isEnabled: true, // To bypass disabling on release builds
            );
          },
        );
}
