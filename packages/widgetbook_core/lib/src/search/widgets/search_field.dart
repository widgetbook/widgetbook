import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.onSearchPressed,
    this.onSearchChanged,
    this.onSearchCancelled,
  });

  final VoidCallback? onSearchPressed;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchCancelled;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  String _searchValue = '';
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      onChanged: (value) {
        setState(() {
          _searchValue = value;
        });
        widget.onSearchChanged?.call(value);
      },
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
            icon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Icon(Icons.search),
            ),
          ),
        ),
        suffixIcon: _searchValue.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(right: 5, left: 10),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _searchValue = '';
                    });
                    textEditingController.clear();
                    focusNode.unfocus();
                    widget.onSearchCancelled?.call();
                  },
                  hoverColor: Colors.white.withOpacity(0.2),
                  icon: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Icon(Icons.close),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
