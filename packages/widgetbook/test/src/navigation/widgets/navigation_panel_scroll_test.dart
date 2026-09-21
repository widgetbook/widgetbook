import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/src/state/state.dart';

import '../../../helper/tester_extension.dart';

/// A tree long enough that most of it sits outside the panel's viewport.
/// Each folder holds one component with one use case, so it collapses onto
/// a single row (see `NavigationTreeNode`'s `isLeafComponent`).
WidgetbookRoot _longTree({required int count}) => WidgetbookRoot(
  children: [
    for (var i = 0; i < count; i++)
      WidgetbookFolder(
        name: 'Folder $i',
        children: [
          WidgetbookComponent(
            name: 'Component $i',
            useCases: [
              WidgetbookUseCase(
                name: 'Use-case $i',
                builder: (_) => Container(),
              ),
            ],
          ),
        ],
      ),
  ],
);

void main() {
  group('$NavigationPanel scrolling to the selected node', () {
    testWidgets(
      'given WidgetbookState.path points to a node far down a long tree, '
      'when the panel first builds, '
      'then it scrolls the node into view',
      (tester) async {
        final tree = _longTree(count: 60);
        const targetPath = 'folder-55/component-55/use-case-55';

        await tester.pumpWidgetWithState(
          state: WidgetbookState(path: targetPath, root: tree),
          builder: (_) => NavigationPanel(root: tree),
        );
        await tester.pumpAndSettle();

        // Off-screen items in a `ListView.builder` aren't built at all, so
        // finding this at all — not just finding it selected — is itself
        // proof the panel scrolled there.
        expect(find.text('Component 55'), findsOneWidget);

        final tile = tester.widget<NavigationTreeTile>(
          find.ancestor(
            of: find.text('Component 55'),
            matching: find.byType(NavigationTreeTile),
          ),
        );
        expect(tile.isSelected, isTrue);
      },
    );

    testWidgets(
      'given the tree is short enough to fit already, '
      'when WidgetbookState.path selects a node inside it, '
      "then the panel doesn't scroll away from the top unnecessarily",
      (tester) async {
        final tree = _longTree(count: 2);

        await tester.pumpWidgetWithState(
          state: WidgetbookState(
            path: 'folder-0/component-0/use-case-0',
            root: tree,
          ),
          builder: (_) => NavigationPanel(root: tree),
        );
        await tester.pumpAndSettle();

        expect(find.text('Component 0'), findsOneWidget);
        expect(find.text('Component 1'), findsOneWidget);
      },
    );

    testWidgets(
      'given the panel already built with one node selected, '
      'when WidgetbookState.path changes to a different node '
      'without a tap in the panel, '
      'then the highlight moves and the new node scrolls into view',
      (tester) async {
        final tree = _longTree(count: 60);

        final state = await tester.pumpWidgetWithState(
          state: WidgetbookState(
            path: 'folder-0/component-0/use-case-0',
            queryParams: {},
            root: tree,
          ),
          builder: (_) => NavigationPanel(root: tree),
        );
        await tester.pumpAndSettle();

        // Simulates a deep link or a VM-service extension — not a tap.
        state.updatePath('folder-58/component-58/use-case-58');
        await tester.pumpAndSettle();

        expect(find.text('Component 58'), findsOneWidget);

        final newTile = tester.widget<NavigationTreeTile>(
          find.ancestor(
            of: find.text('Component 58'),
            matching: find.byType(NavigationTreeTile),
          ),
        );
        expect(newTile.isSelected, isTrue);

        // The previously selected tile is out of the cache range again —
        // scrolled far past it — and so isn't built any more; if it were
        // still built, it would need to no longer report as selected.
        final oldTileFinder = find.ancestor(
          of: find.text('Component 0'),
          matching: find.byType(NavigationTreeTile),
        );
        if (oldTileFinder.evaluate().isNotEmpty) {
          expect(
            tester.widget<NavigationTreeTile>(oldTileFinder).isSelected,
            isFalse,
          );
        }
      },
    );

    testWidgets(
      'given this panel sits inside a widget that never rebuilds it '
      '(as DesktopLayout does, through package:resizable_widget), '
      'when WidgetbookState.path changes, '
      'then the highlight still updates',
      (tester) async {
        final tree = _longTree(count: 3);

        // `_AlwaysStatic` reproduces how `resizable_widget` freezes
        // `DesktopLayout`'s navigation panel — see its own doc comment.
        final state = await tester.pumpWidgetWithState(
          state: WidgetbookState(
            path: 'folder-0/component-0/use-case-0',
            queryParams: {},
            root: tree,
          ),
          builder: (_) => _AlwaysStatic(child: NavigationPanel(root: tree)),
        );
        await tester.pumpAndSettle();

        state.updatePath('folder-2/component-2/use-case-2');
        await tester.pumpAndSettle();

        final tile = tester.widget<NavigationTreeTile>(
          find.ancestor(
            of: find.text('Component 2'),
            matching: find.byType(NavigationTreeTile),
          ),
        );
        expect(tile.isSelected, isTrue);
      },
    );
  });
}

/// Freezes [child] at whatever it was on the first build, exactly like
/// `resizable_widget`'s `_ResizableWidgetState` freezes its `children`.
class _AlwaysStatic extends StatefulWidget {
  const _AlwaysStatic({required this.child});

  final Widget child;

  @override
  State<_AlwaysStatic> createState() => _AlwaysStaticState();
}

class _AlwaysStaticState extends State<_AlwaysStatic> {
  late final _frozen = widget.child;

  @override
  Widget build(BuildContext context) => _frozen;
}
