import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../settings/settings.dart';
import 'base_layout.dart';

class DesktopLayout extends StatelessWidget implements BaseLayout {
  const DesktopLayout({
    super.key,
    required this.addons,
    required this.knobs,
    required this.navigation,
    required this.workbench,
  });

  final List<Widget> addons;
  final List<Widget> knobs;
  final Widget navigation;
  final Widget workbench;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: ResizableWidget(
        separatorSize: 2,
        percentages: [0.2, 0.6, 0.2],
        separatorColor: Colors.white24,
        children: [
          ExcludeSemantics(
            child: navigation,
          ),
          workbench,
          ExcludeSemantics(
            child: SettingsPanel(
              settings: [
                if (addons.isNotEmpty) ...{
                  SettingsPanelData(
                    name: 'Addons',
                    children: addons,
                  ),
                },
                SettingsPanelData(
                  name: 'Knobs',
                  children: knobs,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
