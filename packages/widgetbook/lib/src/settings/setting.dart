import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({
    super.key,
    required this.name,
    this.description,
    this.trailing,
    required this.child,
  });

  final String name;
  final String? description;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              if (trailing != null) ...{
                const SizedBox(width: 8),
                trailing!,
              },
            ],
          ),
          const SizedBox(height: 12),
          if (description != null) ...{
            Text(description!),
            const SizedBox(height: 12),
          },
          child,
        ],
      ),
    );
  }
}
