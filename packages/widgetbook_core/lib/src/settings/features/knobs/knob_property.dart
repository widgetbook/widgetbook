import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/settings/features/knobs/knob_description.dart';
import 'package:widgetbook_core/src/settings/widgets/widgets.dart';

class KnobProperty<T> extends StatefulWidget {
  const KnobProperty({
    super.key,
    required this.name,
    required this.description,
    required this.value,
    required this.child,
    this.trailing,
    this.changedNullable,
  });

  final String name;
  final String? description;
  final T value;

  final Widget child;
  final Widget? trailing;
  final void Function(bool isNull)? changedNullable;

  @override
  State<KnobProperty<T>> createState() => _KnobPropertyState<T>();
}

class _KnobPropertyState<T> extends State<KnobProperty<T>> {
  bool get isNullable => null is T;

  late bool isNull;

  @override
  void initState() {
    super.initState();
    isNull = widget.value == null;
  }

  @override
  Widget build(BuildContext context) {
    final trailingWidget = widget.trailing;
    return Setting(
      name: widget.name,
      trailing: trailingWidget != null || isNullable
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trailingWidget != null) trailingWidget,
                if (trailingWidget != null && isNullable)
                  const SizedBox(
                    width: 8,
                  ),
                if (isNullable)
                  Switch(
                    value: isNull,
                    onChanged: (value) {
                      setState(() {
                        isNull = value;
                      });
                      widget.changedNullable?.call(value);
                    },
                  ),
              ],
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          KnobDescription(
            description: widget.description,
          ),
          widget.child
        ],
      ),
    );
  }
}
