import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/app_info/models/app_info.dart';
import 'package:widgetbook/src/navigation/models/models.dart';
import 'package:widgetbook/src/navigation/providers/navigation_tree_provider.dart';
import 'package:widgetbook/src/navigation/providers/preview_provider.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({
    super.key,
    required this.appInfo,
  });

  final AppInfo appInfo;

  @override
  Widget build(BuildContext context) {
    final navigationTree = context.watch<NavigationTreeProvider>().state;

    return Container(
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 400),
      child: Card(
        color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SearchField(
                onSearchPressed: () {},
                onSearchChanged: (String value) {
                  context.read<NavigationTreeProvider>().filter(value);
                },
                onSearchCancelled: () {
                  context.read<NavigationTreeProvider>().resetFilter();
                },
              ),
            ),
            // const SearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: NavigationTree(
                nodes: navigationTree.filteredNodes,
                selectedNode:
                    context.watch<PreviewProvider>().state.selectedUseCase,
                onNodeSelected: (data) {
                  if (data is WidgetbookUseCase) {
                    context.read<PreviewProvider>().selectUseCase(data);
                    navigate(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
