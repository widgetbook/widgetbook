import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/bloc_mocks.dart';
import '../../../helper/widget_tester_extension.dart';

void main() {
  group('$NavigationPanel', () {
    const nodes = [
      NavigationTreeNodeData(
        path: 'component',
        name: 'Component',
        type: NavigationNodeType.component,
        children: [
          NavigationTreeNodeData(
            path: 'component/use-case-1',
            name: 'Use Case 1',
            type: NavigationNodeType.useCase,
          ),
        ],
      ),
      NavigationTreeNodeData(
        path: 'category',
        name: 'Category',
        type: NavigationNodeType.category,
        children: [],
      ),
    ];

    late NavigationBloc navigationBloc;
    setUp(() {
      navigationBloc = MockNavigationBloc();
    });

    testWidgets(
      'Triggers $FilterNavigationNodes when typing into search field',
      (WidgetTester tester) async {
        when(() => navigationBloc.state).thenReturn(
          NavigationState(
            nodes: nodes,
            filteredNodes: nodes,
          ),
        );

        await tester.pumpWidgetWithMaterial(
          child: BlocProvider.value(
            value: navigationBloc,
            child: const NavigationPanel(),
          ),
        );
        await tester.pumpAndSettle();
        const query = 'component';

        await tester.enterText(find.byType(TextFormField), query);
        verify(
          () => navigationBloc
              .add(const FilterNavigationNodes(searchQuery: query)),
        ).called(1);
      },
    );

    testWidgets(
      'Triggers $ResetNodesFilter when search field is cleared',
      (WidgetTester tester) async {
        const query = 'component';

        when(() => navigationBloc.state).thenReturn(
          NavigationState(
            nodes: nodes,
            filteredNodes: nodes,
            searchQuery: query,
          ),
        );

        await tester.pumpWidgetWithMaterial(
          child: BlocProvider.value(
            value: navigationBloc,
            child: const NavigationPanel(),
          ),
        );
        await tester.pumpAndSettle();

        final clearButtonFinder = find.byWidgetPredicate(
          (widget) => widget is Icon && widget.icon == Icons.close,
        );
        await tester.tap(clearButtonFinder);

        verify(
          () => navigationBloc.add(const ResetNodesFilter()),
        ).called(1);
      },
    );
  });
}
