import 'package:flutter/material.dart';

import 'base/builder_addon.dart';

class GridAddon extends BuilderAddon {
  GridAddon([int dimension = 50])
      : assert(dimension > 0),
        super(
          name: 'Grid',
          builder: (context, child) {
            return Stack(
              children: [
                GridPaper(
                  color: Colors.grey.withAlpha(255 ~/ 2),
                  interval: dimension.toDouble(),
                  subdivisions: 2,
                  child: Container(),
                ),
                child,
              ],
            );
          },
        );
}
