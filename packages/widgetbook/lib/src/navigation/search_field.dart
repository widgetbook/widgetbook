import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.onChanged,
    this.onCleared,
    this.value = '',
  });

  final ValueChanged<String>? onChanged;
  final VoidCallback? onCleared;
  final String value;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController controller;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(
        color: Colors.transparent,
        width: 0,
      ),
    );

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: 'Search',
        enabledBorder: border,
        focusedBorder: border,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.search),
        ),
        suffixIcon:
            widget.value.isNotEmpty
                ? Padding(
                  padding: const EdgeInsets.only(
                    right: 6,
                    left: 12,
                  ),
                  child: IconButton(
                    onPressed: () {
                      controller.clear();
                      focusNode.unfocus();
                      widget.onCleared?.call();
                    },
                    hoverColor: Colors.white.withAlpha(25),
                    icon: const Icon(Icons.close),
                  ),
                )
                : null,
      ),
    );
  }
}
