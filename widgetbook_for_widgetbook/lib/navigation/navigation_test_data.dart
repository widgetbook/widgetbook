import 'package:widgetbook_core/widgetbook_core.dart';

const testNode1 = NavigationTreeNodeData(
  name: 'Component',
  type: NavigationNodeType.component,
  children: [
    NavigationTreeNodeData(
      id: 'use_case_1_id',
      name: 'Use Case 1',
      type: NavigationNodeType.useCase,
    ),
    NavigationTreeNodeData(
      id: 'use_case_2_id',
      name: 'Use Case 2',
      type: NavigationNodeType.useCase,
    ),
  ],
);

const testNode2 = NavigationTreeNodeData(
  name: 'Component',
  type: NavigationNodeType.component,
  children: [
    NavigationTreeNodeData(
      id: 'use_case_3_id',
      name: 'Use Case 3',
      type: NavigationNodeType.useCase,
    ),
  ],
);

const testNode3 = NavigationTreeNodeData(
  name: 'Category',
  type: NavigationNodeType.category,
  children: [
    testNode1,
    testNode2,
  ],
);

const testNode4 = NavigationTreeNodeData(
  name: 'Component',
  type: NavigationNodeType.component,
  children: [
    NavigationTreeNodeData(
      id: 'use_case_4_id',
      name: 'Use Case 4',
      type: NavigationNodeType.useCase,
    ),
    NavigationTreeNodeData(
      id: 'use_case_5_id',
      name: 'Use Case 5',
      type: NavigationNodeType.useCase,
    ),
  ],
);

const testNode5 = NavigationTreeNodeData(
  name: 'Package',
  type: NavigationNodeType.package,
  children: [
    testNode3,
    testNode2,
  ],
);

const testNode6 = NavigationTreeNodeData(
  name: 'Package',
  type: NavigationNodeType.package,
  children: [
    NavigationTreeNodeData(
      name: 'Component',
      type: NavigationNodeType.component,
      children: [
        NavigationTreeNodeData(
          id: 'use_case_6_id',
          name: 'Use Case 6',
          type: NavigationNodeType.useCase,
        ),
        NavigationTreeNodeData(
          id: 'use_case_7_id',
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
