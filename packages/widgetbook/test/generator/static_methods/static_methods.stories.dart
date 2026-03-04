import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'static_methods.stories.g.dart';

typedef MyBuilder = Widget Function(BuildContext context);

class StaticMethodWidget extends StatelessWidget {
  static Widget _defaultBuilder(BuildContext context) {
    return const Text('default');
  }

  const StaticMethodWidget({
    super.key,
    this.builder = _defaultBuilder,
  });

  final MyBuilder builder;

  @override
  Widget build(BuildContext context) => builder(context);
}

const meta = Meta<StaticMethodWidget>();

final $Default = Object();
