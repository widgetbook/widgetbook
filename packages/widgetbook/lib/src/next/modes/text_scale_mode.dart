import '../../addons/addons.dart';
import 'mode.dart';

class TextScaleMode extends TextScaleAddon with Mode<double> {
  TextScaleMode({
    required super.scales,
    super.initialScale,
  });
}
