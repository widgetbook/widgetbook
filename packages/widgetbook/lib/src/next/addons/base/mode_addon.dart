// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';

import 'addon.dart';
import 'experimental_addon.dart';
import 'mode.dart';

abstract class ModeAddon<T> extends Addon<T> with ExperimentalAddon<T> {
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
