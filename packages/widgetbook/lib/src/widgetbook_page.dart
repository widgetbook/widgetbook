import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/app_info/app_info_provider.dart';
import 'package:widgetbook/src/navigation/navigation_panel.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
import 'package:widgetbook/src/settings_panel/settings_panel.dart';
import 'package:widgetbook/src/styled_widgets/styled_scaffold.dart';
import 'package:widgetbook/src/widgets/multi_split_view.dart';
import 'package:widgetbook/src/workbench/workbench.dart';

class WidgetbookPage<CustomTheme> extends StatelessWidget {
  const WidgetbookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Builder(
          builder: (context) {
            final appInfo = context.watch<AppInfoProvider>().state;
            final state = context.watch<OrganizerProvider>().state;
            return TrippleSplitView(
              leftChild: NavigationPanel(
                appInfo: appInfo,
                categories: state.filteredCategories,
              ),
              centerChild: Workbench<CustomTheme>(),
              rightChild: SettingsPanel<CustomTheme>(),
            );
          },
        ),
      ),
    );
  }
}
