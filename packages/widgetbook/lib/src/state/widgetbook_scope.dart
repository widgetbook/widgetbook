import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'widgetbook_state.dart';

@internal
class WidgetbookScope extends InheritedNotifier<WidgetbookState> {
  WidgetbookScope({
    super.key,
    required WidgetbookState state,
    required super.child,
  }) : super(
          notifier: state,
        );
}
