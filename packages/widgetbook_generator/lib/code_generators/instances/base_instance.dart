import 'package:meta/meta.dart';

@immutable
abstract class BaseInstance {
  const BaseInstance();
  String toCode();
}
