import 'package:flutter/material.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class NavigationTreeItem extends StatefulWidget {
  const NavigationTreeItem({
    super.key,
    this.level = 0,
    this.label,
    this.content,
    this.iconData,
    this.icon,
    this.onTap,
    this.isExpanded = false,
    this.onMoreIconPressed,
  })  : assert(
          label != null || content != null,
          'Either a label or content must be provided',
        ),
        assert(
          icon != null || iconData != null,
          'Either an icon or iconData must be provided',
        );

  const NavigationTreeItem.category({
    super.key,
    required this.label,
    this.onTap,
    this.isExpanded = false,
    this.onMoreIconPressed,
  })  : level = 0,
        iconData = Icons.auto_awesome_mosaic,
        icon = null,
        content = null;

  const NavigationTreeItem.package({
    super.key,
    required this.label,
    this.onTap,
    this.isExpanded = false,
    this.onMoreIconPressed,
  })  : level = 0,
        iconData = Icons.inventory,
        icon = null,
        content = null;

  const NavigationTreeItem.folder({
    super.key,
    required this.label,
    this.onTap,
    this.isExpanded = false,
    this.level = 0,
    this.onMoreIconPressed,
  })  : iconData = Icons.folder,
        icon = null,
        content = null;

  const NavigationTreeItem.component({
    super.key,
    required this.label,
    this.level = 0,
    this.onTap,
    this.isExpanded = false,
    this.onMoreIconPressed,
  })  : iconData = null,
        icon = const ComponentIcon(),
        content = null;

  const NavigationTreeItem.useCase({
    super.key,
    required this.label,
    this.level = 0,
    this.onTap,
    this.isExpanded,
    this.onMoreIconPressed,
  })  : iconData = null,
        icon = const UseCaseIcon(),
        content = null;

  static const double indentation = 25;
  static const double iconSize = 34;

  final int level;
  final String? label;
  final Widget? content;
  final Widget? icon;
  final IconData? iconData;

  final VoidCallback? onTap;
  final VoidCallback? onMoreIconPressed;
  final bool? isExpanded;

  @override
  State<NavigationTreeItem> createState() => _NavigationTreeItemState();
}

class _NavigationTreeItemState extends State<NavigationTreeItem> {
  final _showMoreIconNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _showMoreIconNotifier.value = true;
      },
      onExit: (_) {
        _showMoreIconNotifier.value = false;
      },
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
              child: widget.isExpanded != null
                  ? ExpanderIcon(
                      isExpanded: widget.isExpanded!,
                      size: NavigationTreeItem.indentation,
                    )
                  : Container(),
            ),
            SizedBox(
              width: NavigationTreeItem.indentation,
              child: widget.icon ?? Icon(widget.iconData, size: 16),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: widget.content ??
                  Text(
                    widget.label!,
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
    );
  }
}
