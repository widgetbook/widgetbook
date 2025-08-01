// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import 'package:inspector/inspector.dart';

import 'base/builder_addon.dart';

class InspectorAddon extends BuilderAddon {
  InspectorAddon()
      : super(
          name: 'Inspector',
          builder: (context, child) {
            return Inspector(
              child: child,
            );
          },
        );
}
