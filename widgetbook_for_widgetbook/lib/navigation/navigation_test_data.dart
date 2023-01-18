import 'package:widgetbook_core/widgetbook_core.dart';

const testNode1 = NavigationTreeNodeData(
  path: 'component',
  name: 'Component',
  type: NavigationNodeType.component,
  children: [
    NavigationTreeNodeData(
      path: 'component/use_case_1_id',
      name: 'Use Case 1',
      type: NavigationNodeType.useCase,
    ),
    NavigationTreeNodeData(
      path: 'component/use_case_2_id',
      name: 'Use Case 2',
      type: NavigationNodeType.useCase,
    ),
  ],
);

const testNode2 = NavigationTreeNodeData(
  path: 'component',
  name: 'Component',
  type: NavigationNodeType.component,
  children: [
    NavigationTreeNodeData(
      path: 'component/use_case_3_id',
      name: 'Use Case 3',
      type: NavigationNodeType.useCase,
    ),
  ],
);

const testNode3 = NavigationTreeNodeData(
  path: 'category',
  name: 'Category',
  type: NavigationNodeType.category,
  children: [
    testNode1,
    testNode2,
  ],
);

const testNode4 = NavigationTreeNodeData(
  path: 'component',
  name: 'Component',
  type: NavigationNodeType.component,
  children: [
    NavigationTreeNodeData(
      path: 'use_case_4_id',
      name: 'Use Case 4',
      type: NavigationNodeType.useCase,
    ),
    NavigationTreeNodeData(
      path: 'use_case_5_id',
      name: 'Use Case 5',
      type: NavigationNodeType.useCase,
    ),
  ],
);

const testNode5 = NavigationTreeNodeData(
  path: 'package',
  name: 'Package',
  type: NavigationNodeType.package,
  children: [
    testNode3,
    testNode2,
  ],
);

const testNode6 = NavigationTreeNodeData(
  path: 'package',
  name: 'Package',
  type: NavigationNodeType.package,
  children: [
    NavigationTreeNodeData(
      path: 'component',
      name: 'Component',
      type: NavigationNodeType.component,
      children: [
        NavigationTreeNodeData(
          path: 'use_case_6_id',
          name: 'Use Case 6',
          type: NavigationNodeType.useCase,
        ),
        NavigationTreeNodeData(
          path: 'use_case_7_id',
          name: 'Use Case 7',
          type: NavigationNodeType.useCase,
        ),
      ],
    )
  ],
);

final testTree = [
  testNode3,
  testNode4,
  testNode6,
];

const directories = [
  MultiChildNavigationNodeData(
    name: 'Package',
    type: NavigationNodeType.package,
    children: [
      MultiChildNavigationNodeData(
        name: 'Component',
        type: NavigationNodeType.component,
        children: [
          LeafNavigationNodeData(
            name: 'Use Case 1',
            type: NavigationNodeType.useCase,
          ),
        ],
      )
    ],
  ),
  MultiChildNavigationNodeData(
    name: 'Category',
    type: NavigationNodeType.category,
    children: [
      MultiChildNavigationNodeData(
        name: 'Component',
        type: NavigationNodeType.component,
        children: [
          LeafNavigationNodeData(
            name: 'Use Case 2',
            type: NavigationNodeType.useCase,
          ),
          LeafNavigationNodeData(
            name: 'Use Case 3',
            type: NavigationNodeType.useCase,
          ),
        ],
      ),
    ],
  ),
];
