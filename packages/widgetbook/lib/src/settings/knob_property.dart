import 'package:flutter/material.dart';

import 'setting.dart';

class KnobProperty<T> extends StatefulWidget {
  const KnobProperty({
    super.key,
    required this.name,
    this.description,
    required this.value,
    required this.child,
    this.isNullable = false,
    this.changedNullable,
  });

  final String name;
  final String? description;
  final T value;
  final bool isNullable;

  final Widget child;
  final void Function(bool isNull)? changedNullable;

  @override
  State<KnobProperty<T>> createState() => _KnobPropertyState<T>();
}

class _KnobPropertyState<T> extends State<KnobProperty<T>> {
  late bool isNull;

  @override
  void initState() {
    super.initState();
    isNull = widget.value == null;
  }

  @override
  Widget build(BuildContext context) {
    return Setting(
      name: widget.name,
      description: widget.description,
      trailing: widget.isNullable
          ? Checkbox(
              value: !isNull,
              onChanged: (value) {
                setState(() => isNull = !value!);
                widget.changedNullable?.call(value!);
              },
            )
          : null,
      child: widget.child,
    );
  }
}
