import 'package:flutter_test/flutter_test.dart';

Matcher throwsAssertion(String message) {
  return throwsA(
    allOf(
      isA<AssertionError>(),
      predicate<AssertionError>((err) => err.message == message),
    ),
  );
}
