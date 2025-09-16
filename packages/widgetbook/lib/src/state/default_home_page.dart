import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgetbook_theme.dart';

@internal
class DefaultHomePage extends StatelessWidget {
  const DefaultHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Widgetbook',
              textAlign: TextAlign.center,
              style: WidgetbookTheme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 24),
            const Wrap(
              children: [
                _Card(
                  title: '📖 Docs',
                  url:
                      'https://docs.widgetbook.io?utm_source=oss&utm_medium=home',
                  description:
                      'Learn more about knobs, addons, mocking, and more.',
                ),
                _Card(
                  title: '📝 Examples',
                  url:
                      'https://github.com/widgetbook/widgetbook/tree/main/examples',
                  description:
                      'Explore the Widgetbook examples and learn how to use them.',
                ),
              ],
            ),
            const Wrap(
              children: [
                _Card(
                  title: '🚀 Deploy',
                  url:
                      'https://docs.widgetbook.io/cloud/builds/overview?utm_source=oss&utm_medium=home',
                  description:
                      'Deploy your Widgetbook with our managed-hosting solution.',
                ),
                _Card(
                  title: '✨ Detect Changes',
                  url:
                      'https://docs.widgetbook.io/cloud/reviews?utm_source=oss&utm_medium=home',
                  description:
                      'Detect visual changes in your PRs with Widgetbook Cloud.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.description,
    required this.url,
  });

  final String title;
  final String description;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 360,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: WidgetbookTheme.of(context).dividerColor.withAlpha(100),
          ),
        ),
        child: InkWell(
          onTap: () => launchUrl(Uri.parse(url)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    style: WidgetbookTheme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: title,
                      ),
                      const TextSpan(text: ' '),
                      const WidgetSpan(
                        child: Icon(
                          Icons.arrow_forward,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: WidgetbookTheme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(
                    color: WidgetbookTheme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(120),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
