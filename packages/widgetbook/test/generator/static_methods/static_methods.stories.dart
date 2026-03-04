import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'static_methods.stories.g.dart';

typedef MyBuilder = Widget Function(BuildContext context);

class StaticMethodWidget extends StatelessWidget {
  const StaticMethodWidget({
    super.key,
    this.builder = _defaultBuilder,
  });

  final MyBuilder builder;

  static Widget _defaultBuilder(BuildContext context) {
    return const Text('default');
  }

  @override
  Widget build(BuildContext context) => builder(context);
}

const meta = Meta<StaticMethodWidget>();

final $Default = Object();
