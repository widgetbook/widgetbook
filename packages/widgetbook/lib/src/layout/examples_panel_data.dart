import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ExamplesPanelData extends StatelessWidget {
  const ExamplesPanelData({
    super.key,
    this.designLink,
    this.documentationLink,
  });

  final String? designLink;
  final String? documentationLink;

  @override
  Widget build(BuildContext context) {
    final designLink = this.designLink;
    final documentationLink = this.documentationLink;

    return Column(
      children: [
        if (designLink != null) ...{
          MaterialButton(
            height: 60,
            onPressed: () {
              launchUrl(Uri.parse(designLink));
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/figma_logo.svg',
                  width: 40,
                  height: 40,
                  package: 'widgetbook',
                ),
                const SizedBox(width: 8),
                const Text(
                  'Figma',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        },
        if (documentationLink != null) ...{
          MaterialButton(
            height: 60,
            onPressed: () {
              launchUrl(Uri.parse(documentationLink));
            },
            child: Row(
              children: [
                const SizedBox(width: 6),
                SvgPicture.asset(
                  'assets/dart_logo.svg',
                  width: 18,
                  height: 18,
                  package: 'widgetbook',
                ),
                const SizedBox(width: 14),
                const Text(
                  'Documentation',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        },
      ],
    );
  }
}
