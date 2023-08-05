import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

extension FinderExtension on CommonFinders {
  /// Same as [CommonFinders.text], but makes sure that the widget is [Text].
  /// Helpful when you have a [TextField] and [Text] at the same time.
  Finder textWidget(String text) {
    return find.byWidgetPredicate(
      (widget) => widget is Text && widget.data == text,
    );
  }
}
