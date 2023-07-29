import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook/src/state/state.dart';

class VoidCallbackMock extends Mock implements Object {
  void call();
}

class ValueChangedCallbackMock<T> extends Mock implements Object {
  void call(T value);
}

class OnNodeSelectedCallbackMock<P, D> extends Mock implements Object {
  void call(P path, D data);
}

class MockWidgetbookState extends Mock implements WidgetbookState {}

class MockBuildContext extends Mock implements BuildContext {}
