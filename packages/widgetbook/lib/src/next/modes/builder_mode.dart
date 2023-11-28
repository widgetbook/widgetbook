import '../../addons/addons.dart';
import 'mode.dart';

class BuilderMode extends BuilderAddon with Mode<void> {
  BuilderMode({
    required super.name,
    required super.builder,
  });
}
