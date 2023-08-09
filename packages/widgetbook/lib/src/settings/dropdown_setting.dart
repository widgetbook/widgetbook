import 'package:flutter/material.dart';

String defaultOptionValueBuilder<T>(T value) {
  return value.toString();
}

class DropdownSetting<T> extends StatelessWidget {
  DropdownSetting({
    super.key,
    required this.options,
    required this.onSelected,
    T? initialSelection,
    String Function(T option)? optionValueBuilder,
  })  : initialSelection = initialSelection ?? options.first,
        optionValueBuilder = optionValueBuilder ?? defaultOptionValueBuilder;

  final List<T> options;
  final T initialSelection;
  final String Function(T option) optionValueBuilder;
  final void Function(T option) onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
      initialSelection: initialSelection,
      onSelected: (value) => onSelected(value as T),
      dropdownMenuEntries: options
          .map(
            (e) => DropdownMenuEntry(
              value: e,
              label: optionValueBuilder(e),
            ),
          )
          .toList(),
    );
  }
}
