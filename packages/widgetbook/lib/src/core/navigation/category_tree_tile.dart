import 'package:flutter/material.dart';

import 'navigation.dart';

class CategoryTreeTile extends StatelessWidget {
  const CategoryTreeTile({
    super.key,
    required this.node,
    this.onTap,
  });

  static const height = 40.0;

  final TreeNode<Null> node;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final name = node.name.substring(1, node.name.length - 1);

    return SizedBox(
      height: height,
      child: Opacity(
        opacity: 0.64,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      name.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.unfold_more,
                    size: 16,
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
