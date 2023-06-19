import 'package:mocktail/mocktail.dart';

class VoidCallbackMock extends Mock implements Object {
  void call();
}

class ValueChangedCallbackMock<T> extends Mock implements Object {
  void call(T value);
}
