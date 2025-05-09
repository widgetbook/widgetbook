import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: implementation_imports
import 'package:widgetbook/src/settings/setting.dart';
import 'package:widgetbook/widgetbook.dart';

/// An addon to display a link to a GitHub repository.
class GitHubAddon extends WidgetbookAddon<void> {
  GitHubAddon(this.repository) : super(name: 'GitHub');

  final String repository;

  @override
  List<Field> get fields {
    return [
      // Since `buildFields` will not be called if the `fields` list is empty,
      // we need to add a dummy field to ensure that the addon is displayed.
      StringField(name: ''),
    ];
  }

  @override
  void valueFromQueryGroup(Map<String, String> group) {}

  @override
  Widget buildFields(BuildContext context) {
    return Setting(
      name: 'Repository',
      child: Row(
        children: [
          ElevatedButton.icon(
            icon: const Icon(FontAwesomeIcons.github, size: 18),
            label: Text(repository),
            onPressed:
                () => launchUrl(Uri.parse('https://github.com/$repository')),
            style: ElevatedButton.styleFrom(
              // ignore: deprecated_member_use
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              padding: const EdgeInsets.all(16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
