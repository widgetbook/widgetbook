import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({
    super.key,
    this.onNodeSelected,
    this.initialPath,
  });

  final NodeSelectedCallback? onNodeSelected;
  final String? initialPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 300),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SearchField(
                searchValue: context.select<NavigationBloc, String>(
                  (bloc) => bloc.state.searchQuery,
                ),
                onSearchChanged: (String value) {
                  context.read<NavigationBloc>().add(
                        FilterNavigationNodes(searchQuery: value),
                      );
                },
                onSearchCancelled: () {
                  context.read<NavigationBloc>().add(const ResetNodesFilter());
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: NavigationTree(
                initialPath: initialPath,
                onNodeSelected: onNodeSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
