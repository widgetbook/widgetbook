import 'package:mocktail/mocktail.dart';

class VoidCallbackMock extends Mock implements Object {
  void call();
}

class ValueChangedCallbackMock<T> extends Mock implements Object {
  void call(T value);
}

class OnNodeSelectedCallbackMock<P, D> extends Mock implements Object {
  void call(P path, D data);
}
