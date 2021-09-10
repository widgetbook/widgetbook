import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook/src/constants/border_radius_constants.dart';
import 'package:widgetbook/src/cubit/canvas/canvas_cubit.dart';
import 'package:widgetbook/src/models/organizers/organizer.dart';
import 'package:widgetbook/src/utils/styles.dart';
import '../../../utils/utils.dart';

class Tile extends StatefulWidget {
  final IconData iconData;
  final Color iconColor;
  final Organizer organizer;
  final VoidCallback? onClicked;

  static const double spacing = 8;

  const Tile({
    Key? key,
    required this.iconData,
    required this.iconColor,
    required this.organizer,
    this.onClicked,
  }) : super(key: key);

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool hovered = false;

  Widget _buildTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: Row(
        children: [
          Icon(
            widget.iconData,
            color: hovered ? context.colorScheme.onPrimary : widget.iconColor,
            size: 16,
          ),
          const SizedBox(
            width: Tile.spacing,
          ),
          Text(widget.organizer.name),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanvasCubit, CanvasState>(
      builder: (context, state) {
        bool isSelected = state.selectedStory == widget.organizer;
        return GestureDetector(
          onTap: () {
            widget.onClicked?.call();
          },
          child: MouseRegion(
            onEnter: (e) {
              setState(() => hovered = true);
            },
            onExit: (e) {
              setState(() => hovered = false);
            },
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: hovered || isSelected
                    ? Styles.getHighlightColor(context)
                    : null,
                borderRadius: BorderRadiusConstants.tileBorderRadius,
              ),
              duration: const Duration(milliseconds: 100),
              child: _buildTile(context),
            ),
          ),
        );
      },
    );
  }
}
