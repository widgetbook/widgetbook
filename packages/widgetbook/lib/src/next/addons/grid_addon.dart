import 'package:flutter/widgets.dart';

import '../../addons/grid_addon/grid_painter.dart';
import 'base/builder_addon.dart';

class GridAddon extends BuilderAddon {
  GridAddon([int dimension = 50])
      : assert(dimension > 0),
        super(
          name: 'Grid',
          builder: (context, child) {
            return Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return CustomPaint(
                      painter: GridPainter(dimension),
                      size: Size(
                        constraints.maxWidth,
                        constraints.maxHeight,
                      ),
                    );
                  },
                ),
                child,
              ],
            );
          },
        );
}
