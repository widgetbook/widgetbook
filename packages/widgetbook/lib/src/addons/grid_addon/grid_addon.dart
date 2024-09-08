import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

class GridAddon extends WidgetbookAddon<int> {
  GridAddon([
    this.dimension = 50,
  ])  : assert(dimension > 0),
        super(
          name: 'Grid',
        );

  final int dimension;

  @override
  List<Field> get fields => [];

  @override
  int valueFromQueryGroup(Map<String, String> group) => dimension;

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    int setting,
  ) {
    return Stack(
      children: [
        GridPaper(
          color: Colors.grey.withOpacity(0.5),
          interval: setting.toDouble(),
          subdivisions: 2,
          child: Container(),
        ),
        child,
      ],
    );
  }
}
