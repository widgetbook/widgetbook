import 'package:flutter/material.dart';
import 'package:widgetbook/test.dart';
import 'package:widgetbook/widgetbook.dart';

// Spike: exercises the accessibility-guideline capture. Each story deliberately
// passes or fails a built-in guideline; run `flutter test` and inspect the
// `violations` arrays in build/.widgetbook/**/*.json.

class _NoArgs extends StoryArgs<Widget> {
  const _NoArgs();

  @override
  List<Arg?> get list => const [];
}

class _Story extends Story<Widget, _NoArgs> {
  _Story({required super.name, required WidgetBuilder build})
      : super(
          args: const _NoArgs(),
          builder: (context, args) => build(context),
        );
}

Component<Widget, _NoArgs> _case(String name, WidgetBuilder build) {
  return Component<Widget, _NoArgs>(
    name: name,
    path: 'Guidelines',
    stories: [_Story(name: 'Default', build: build)],
  );
}

Widget _frame(Widget child, {Color color = const Color(0xFFFFFFFF)}) {
  return SizedBox(
    width: 240,
    height: 150,
    child: ColoredBox(color: color, child: Center(child: child)),
  );
}

final config = Config(
  components: [
    // Tappable below 48x48 → fails androidTapTargetGuideline (+ iOS 44).
    // Labeled, so it passes the labeled guideline.
    _case('Undersized tap target', (context) {
      return _frame(
        Semantics(
          container: true,
          button: true,
          label: 'Like',
          onTap: () {},
          child: const SizedBox(
            width: 24,
            height: 24,
            child: ColoredBox(color: Color(0xFFC62828)),
          ),
        ),
      );
    }),

    // Tappable with no label → fails labeledTapTargetGuideline.
    // 60x60, so it passes the tap-target guidelines.
    _case('Unlabeled tap target', (context) {
      return _frame(
        Semantics(
          container: true,
          button: true,
          onTap: () {},
          child: const SizedBox(
            width: 60,
            height: 60,
            child: ColoredBox(color: Color(0xFF1565C0)),
          ),
        ),
      );
    }),

    // Light grey text on white → fails textContrastGuideline.
    _case('Low contrast text', (context) {
      return _frame(
        const Text(
          'Low contrast text',
          style: TextStyle(color: Color(0xFFCFCFCF), fontSize: 16),
        ),
      );
    }),

    // 48x48, labeled, no text → should pass every guideline (control).
    _case('Compliant control', (context) {
      return _frame(
        Semantics(
          container: true,
          button: true,
          label: 'Save',
          onTap: () {},
          child: const SizedBox(
            width: 48,
            height: 48,
            child: ColoredBox(color: Color(0xFF2E7D32)),
          ),
        ),
      );
    }),
  ],
);

Future<void> main() async {
  await testWidgetbook(config);
}
