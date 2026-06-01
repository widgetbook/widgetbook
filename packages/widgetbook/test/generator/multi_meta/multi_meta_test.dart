// Tests that multiple `Meta<TWidget>` variables in one file produce a single
// aggregated `${Widget}Component` typed as `Component<TWidget,
// StoryArgs<TWidget>>`, with per-constructor Args and Story classes.

@TestOn('vm')
library;

import '../helper.dart';

void main() {
  test(
    'aggregates per-constructor args and story classes under one component',
    () async {
      await testStoryGenerator('multi_meta');
    },
  );
}
