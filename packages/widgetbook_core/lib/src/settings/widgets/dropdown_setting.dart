import 'package:flutter/material.dart';

String defaultOptionValueBuilder<T>(T value) {
  return value.toString();
}

class DropdownSetting<T> extends StatelessWidget {
  DropdownSetting({
    super.key,
    required this.options,
    T? initialSelection,
    String Function(T)? optionValueBuilder,
    required this.onSelected,
  })  : initialSelection = initialSelection ?? options.first,
        optionValueBuilder = optionValueBuilder ?? defaultOptionValueBuilder;

  final List<T> options;
  final T initialSelection;
  final String Function(T) optionValueBuilder;
  final void Function(T) onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DropdownMenu<T>(
      initialSelection: initialSelection,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 24),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        filled: true,
        fillColor: Colors.transparent,
        hoverColor: colorScheme.onBackground.withOpacity(0.08),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onBackground.withOpacity(0.12),
          ),
        ),
      ),
      trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
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
