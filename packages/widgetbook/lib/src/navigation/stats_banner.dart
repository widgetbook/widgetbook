import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/theme.dart';

/// A banner widget that displays statistics about the components and use-cases
/// in the Widgetbook.
@internal
class StatsBanner extends StatelessWidget {
  const StatsBanner({
    super.key,
    required this.componentsCount,
    required this.storiesCount,
  });

  final int componentsCount;
  final int storiesCount;

  String _pluralize(int count, String singular, String plural) {
    return '$count ${count == 1 ? singular : plural}';
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.64,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: WidgetbookTheme.of(context).colorScheme.outline,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SummaryItem(
                icon: Icons.info_outline,
                text:
                    '${_pluralize(componentsCount, 'Component', 'Components')} • '
                    '${_pluralize(storiesCount, 'Story', 'Stories')}',
              ),
              const SizedBox(height: 2),
              const _SummaryItem(
                icon: Icons.open_in_new,
                text: 'Golden test with Widgetbook Cloud',
                url:
                    'https://docs.widgetbook.io/cloud?utm_source=oss&utm_medium=banner',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.text,
    required this.icon,
    this.url,
  });

  final String text;
  final IconData icon;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final isClickable = url != null;

    return GestureDetector(
      onTap: isClickable ? () => launchUrl(Uri.parse(url!)) : null,
      behavior: HitTestBehavior.opaque,
      child: MouseRegion(
        cursor: isClickable ? SystemMouseCursors.click : MouseCursor.defer,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 16,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                text,
                style: WidgetbookTheme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(
                  decoration: isClickable ? TextDecoration.underline : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
