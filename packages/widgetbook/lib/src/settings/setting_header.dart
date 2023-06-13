import 'package:flutter/material.dart';

class SettingHeader extends StatelessWidget {
  const SettingHeader({
    super.key,
    required this.content,
    this.trailing,
  });

  final String content;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final trail = trailing;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              content,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trail != null)
            Row(
              children: [
                const SizedBox(width: 8),
                trail,
              ],
            ),
        ],
      ),
    );
  }
}
