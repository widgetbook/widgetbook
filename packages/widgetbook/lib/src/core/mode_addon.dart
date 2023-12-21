import 'package:flutter/widgets.dart';

import 'addon.dart';
import 'mode.dart';

abstract class ModeAddon<T> extends Addon<T> {
  ModeAddon({
    required super.name,
    required this.modeBuilder,
  });

  final Mode<T> Function(T) modeBuilder;

  @override
  Widget buildUseCase(BuildContext context, Widget child, T setting) {
    final mode = modeBuilder(setting);
    return mode.build(context, child);
  }
}
