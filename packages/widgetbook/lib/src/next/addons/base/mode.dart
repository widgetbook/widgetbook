// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';

abstract class Mode<T> {
  Mode(this.value);

  final T value;

  Widget build(BuildContext context, Widget child);
}
