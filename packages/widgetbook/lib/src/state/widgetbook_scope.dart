import 'package:flutter/widgets.dart';

import 'widgetbook_state.dart';

class WidgetbookScope extends InheritedNotifier<WidgetbookState> {
  WidgetbookScope({
    required WidgetbookState state,
    required super.child,
  }) : super(
          notifier: state,
        );
}
