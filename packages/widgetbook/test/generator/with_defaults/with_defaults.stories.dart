import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'with_defaults.stories.g.dart';

/// Tests that a top-level `defaults` variable pipes defaults.setup and
/// defaults.builder into the Story's super constructor initializers.
const description = 'pipes defaults.setup and defaults.builder into Story';

class DefaultsVarWidget extends StatelessWidget {
  const DefaultsVarWidget({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Text(label);
}

class DefaultsVarInput {
  const DefaultsVarInput({required this.label});

  final String label;
}

const meta = Meta(DefaultsVarWidget.new, argsType: DefaultsVarInput.new);

final defaults = _Defaults(
  setup: (context, child, args) => child,
  builder: (context, args) => DefaultsVarWidget(label: args.label),
);

final $Default = _Story();
