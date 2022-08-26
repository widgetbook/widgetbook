import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/app_info/app_info_provider.dart';
import 'package:widgetbook/src/navigation/navigation_panel.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
import 'package:widgetbook/src/settings_panel/settings_panel.dart';
import 'package:widgetbook/src/styled_widgets/styled_scaffold.dart';
import 'package:widgetbook/src/widgets/multi_split_view.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class WidgetbookPage extends StatelessWidget {
  const WidgetbookPage({
    Key? key,
    required this.disableNavigation,
    required this.disableProperties,
    required this.routerData,
  }) : super(key: key);

  final bool disableNavigation;
  final bool disableProperties;
  final Map<String, dynamic> routerData;

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Builder(
          builder: (context) {
            final addons = context.watch<AddOnProvider>().value;
            final appInfo = context.watch<AppInfoProvider>().state;
            final state = context.watch<OrganizerProvider>().state;
            return Nested(
              children: addons
                  .map(
                    (e) => SingleChildBuilder(
                      builder: (context, child) => e.wrapperBuilder(
                        context,
                        routerData,
                        child!,
                      ),
                    ),
                  )
                  .toList(),
              child: TrippleSplitView(
                isLeftDisabled: disableNavigation,
                isRightDisabled: disableProperties,
                leftChild: NavigationPanel(
                  appInfo: appInfo,
                  categories: state.filteredCategories,
                ),
                centerChild: Workbench(
                  routerData: routerData,
                ),
                rightChild: const SettingsPanel(),
              ),
            );
          },
        ),
      ),
    );
  }
}
