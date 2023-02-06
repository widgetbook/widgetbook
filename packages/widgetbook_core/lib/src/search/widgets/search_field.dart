import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.onSearchPressed,
    this.onSearchChanged,
    this.onSearchCancelled,
    this.searchValue = '',
  });

  final VoidCallback? onSearchPressed;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchCancelled;
  final String searchValue;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController textEditingController;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.searchValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      onChanged: widget.onSearchChanged,
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
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5, right: 10),
          child: IconButton(
            onPressed: widget.onSearchPressed,
            hoverColor: Colors.white.withOpacity(0.2),
            icon: const Icon(Icons.search),
          ),
        ),
        suffixIcon: widget.searchValue.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(right: 5, left: 10),
                child: IconButton(
                  onPressed: () {
                    textEditingController.clear();
                    focusNode.unfocus();
                    widget.onSearchCancelled?.call();
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
