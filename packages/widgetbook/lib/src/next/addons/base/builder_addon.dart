// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';

import '../../../fields/fields.dart';
import 'addon.dart';
import 'experimental_addon.dart';

typedef ChildBuilder = Widget Function(BuildContext context, Widget child);

class BuilderAddon extends Addon<void> with ExperimentalAddon {
  BuilderAddon({
    required super.name,
    required this.builder,
  });

  final ChildBuilder builder;

  @override
  List<Field> get fields => [];

  @override
  void valueFromQueryGroup(Map<String, String> group) {}

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    void setting,
  ) {
    return builder(context, child);
  }
}
