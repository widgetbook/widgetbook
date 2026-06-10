import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'variants.stories.g.dart';

class VariantButton extends StatelessWidget {
  const VariantButton({
    super.key,
    required this.label,
  }) : icon = null,
       size = 24;

  const VariantButton.icon({
    super.key,
    required this.icon,
    this.size = 24,
  }) : label = '';

  factory VariantButton.outlined({
    Key? key,
    required String label,
  }) {
    return VariantButton(key: key, label: label);
  }

  final String label;
  final IconData? icon;
  final double size;

  @override
  Widget build(BuildContext context) => Text(label);
}

const component = ComponentMeta(
  name: 'Variant Button',
  path: 'buttons',
);

const meta = Meta(VariantButton.new);

const iconMeta = Meta(VariantButton.icon);

const outlinedMeta = Meta(VariantButton.outlined);

final defaults = _Defaults(
  builder: (context, args) => VariantButton(label: args.label),
);

// The name of a defaults variable does not matter,
// only its type is used to match it to a variant.
final customIconDefaults = _IconDefaults(
  setup: (context, child, args) => child,
);

VariantButton buildOutlined(BuildContext context, _OutlinedArgs args) {
  return VariantButton.outlined(label: args.label);
}

// Defaults can also be declared as const.
const outlinedDefaults = _OutlinedDefaults(builder: buildOutlined);

final $Default = _Story();

final $Icon = _IconStory();

final $IconLarge = _IconStory(
  args: _IconArgs(size: DoubleArg(48)),
);

final $Outlined = _OutlinedStory();
