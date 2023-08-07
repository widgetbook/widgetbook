import 'package:mocktail/mocktail.dart';

// Function without parameters

class FnMock<R> extends Mock implements Object {
  R call();
}

class VoidFnMock extends Mock implements FnMock<void> {}

// ---------------------------------------------

// Function with 1 parameter

class Fn1Mock<R, P1> extends Mock implements Object {
  R call(P1 param1);
}

class VoidFn1Mock<P1> extends Mock implements Fn1Mock<void, P1> {}

// ---------------------------------------------

// Function with 2 parameters

class Fn2Mock<R, P1, P2> extends Mock implements Object {
  R call(P1 param1, P2 param2);
}

class VoidFn2Mock<P1, P2> extends Mock implements Fn2Mock<void, P1, P2> {}

// ---------------------------------------------

// Function with 3 parameters

class Fn3Mock<R, P1, P2, P3> extends Mock implements Object {
  R call(P1 param1, P2 param2, P3 param3);
}

class VoidFn3Mock<P1, P2, P3> extends Mock
    implements Fn3Mock<void, P1, P2, P3> {}

// ---------------------------------------------
