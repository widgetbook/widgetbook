import 'package:flutter/material.dart';

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
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: 'Search',
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(50),
        ),
        filled: true,
        focusColor: Colors.white,
        iconColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.search),
        ),
        suffixIcon: widget.value.isNotEmpty
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
                  hoverColor: Colors.white.withOpacity(0.2),
                  icon: const Icon(Icons.close),
                ),
              )
            : null,
      ),
    );
  }
}
