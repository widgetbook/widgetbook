import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

// Drives the *generated* args class of an existing generator fixture, so this
// test is tied to real generator output rather than a hand-written mimic. When
// the generator is fixed (and goldens are regenerated), `PrimitiveWidgetArgs`
// here updates automatically and the failing test below turns green.
import '../../generator/primitive/primitive.stories.dart';

void main() {
  // Reproduces issue #1: building a story/scenario with the generated
  // `_Args.fixed(...)` constructor and then reading an arg's `name` throws
  //
  //   LateInitializationError: Field '$generatedName' has not been initialized.
  //     Arg.name           (lib/src/core/framework/arg.dart)
  //     ResponsiveLayout.buildScenarioInfo
  //       (lib/src/core/layout/responsive_layout.dart)
  //
  // Root cause: the generated `.fixed` constructor assigns each field with a
  // bare `Arg.fixed(value)` (-> `ConstArg`, whose `_name` is null) and never
  // routes through `$initArg(...)`, which is what assigns `$generatedName`.
  // The default constructor does call `$initArg(...)`, so its args are fine.
  group('Arg.name for generated StoryArgs', () {
    test('default constructor exposes parameter names (control)', () {
      final args = PrimitiveWidgetArgs();

      final names = args.list.whereType<Arg>().map((arg) => arg.name).toList();

      expect(names, containsAll(['label', 'count', 'isActive']));
    });

    test(
      '`.fixed` constructor exposes parameter names too (regression for #1)',
      () {
        final args = PrimitiveWidgetArgs.fixed(
          label: 'Hello',
          count: 1,
          isActive: true,
        );

        // This is exactly what `ResponsiveLayout.buildScenarioInfo` does when
        // it renders the "Args" table for a scenario/story. Before the fix it
        // threw a LateInitializationError because `$generatedName` was never
        // assigned for fixed args.
        final names =
            args.list.whereType<Arg>().map((arg) => arg.name).toList();

        expect(names, containsAll(['label', 'count', 'isActive']));
      },
    );
  });
}
