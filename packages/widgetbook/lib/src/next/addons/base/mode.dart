import 'package:flutter/widgets.dart';

abstract class Mode<T> {
  Mode(this.value);

  final T value;

  Widget build(BuildContext context, Widget child);
}
