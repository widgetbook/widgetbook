import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Returns the first element of a finder
Finder firstSelector(Finder finder) {
  return finder.first;
}

extension FinderExtension on WidgetTester {
  /// Returns the [BuildContext] of the [widget].
  BuildContext findContextByWidget(
    Widget widget, {
    Finder Function(Finder finder) selector = firstSelector,
  }) {
    final results = find.byWidget(
      widget,
    );
    return element(
      selector(results),
    );
  }

  /// Returns the [BuildContext] of the [Key].
  BuildContext findContextByKey(
    Key key, {
    Finder Function(Finder finder) selector = firstSelector,
  }) {
    final results = find.byKey(
      key,
    );
    return element(
      selector(results),
    );
  }
}
