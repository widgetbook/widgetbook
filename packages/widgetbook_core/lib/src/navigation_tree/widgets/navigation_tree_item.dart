import 'package:flutter/material.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class NavigationTreeItem extends StatefulWidget {
  const NavigationTreeItem({
    super.key,
    this.level = 0,
    required this.data,
    this.onTap,
    this.isExpanded = false,
    this.onMoreIconPressed,
    this.isSelected = false,
  });

  static const double indentation = 25;
  static const double iconSize = 34;

  final int level;
  final NavigationTreeNodeData data;
  final VoidCallback? onTap;
  final VoidCallback? onMoreIconPressed;
  final bool isExpanded;
  final bool isSelected;

  @override
  State<NavigationTreeItem> createState() => _NavigationTreeItemState();
}

class _NavigationTreeItemState extends State<NavigationTreeItem> {
  final _showMoreIconNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.data.isSelectable && widget.isSelected;
    return MouseRegion(
      onEnter: (_) {
        _showMoreIconNotifier.value = true;
      },
      onExit: (_) {
        _showMoreIconNotifier.value = false;
      },
      child: Material(
        elevation: isSelected ? 3 : 0,
        shadowColor: isSelected ? Colors.black : Colors.transparent,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(NavigationTreeItem.iconSize),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(NavigationTreeItem.iconSize),
          child: ColoredBox(
            color: isSelected
                ? Theme.of(context).colorScheme.secondaryContainer
                : Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(NavigationTreeItem.iconSize),
              child: Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      widget.level,
                      (index) =>
                          const SizedBox(width: NavigationTreeItem.indentation),
                    ),
                  ),
                  SizedBox(
                    width: NavigationTreeItem.indentation,
                    child: widget.data.isExpandable
                        ? ExpanderIcon(
                            isExpanded: widget.isExpanded,
                            size: NavigationTreeItem.indentation,
                          )
                        : Container(),
                  ),
                  SizedBox(
                    width: NavigationTreeItem.indentation,
                    child: widget.data.icon,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.data.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _showMoreIconNotifier,
                    builder: (context, bool showMoreIcon, child) {
                      return SizedBox(
                        height: NavigationTreeItem.iconSize,
                        width: NavigationTreeItem.iconSize,
                        child: showMoreIcon
                            ? InkWell(
                                onTap: widget.onMoreIconPressed,
                                borderRadius: BorderRadius.circular(
                                  NavigationTreeItem.iconSize,
                                ),
                                child: const Icon(
                                  Icons.more_vert_rounded,
                                  size: 20,
                                ),
                              )
                            : Container(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
