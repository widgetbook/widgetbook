import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
import 'package:widgetbook/src/utils/utils.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO how to handle dark and light theme of the app?
    final fillColor = ThemeMode.dark == ThemeMode.light
        ? Styles.lightSurface
        : Styles.darkSurface;
    final onFillColor = ThemeMode.dark == ThemeMode.light
        ? Styles.onLightSurface
        : Styles.onDarkSurface;

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
      borderRadius: Radii.defaultRadius,
    );

    return TextField(
      key: Key('$SearchBar.$TextField'),
      controller: controller,
      cursorWidth: 3,
      cursorColor: onFillColor,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'search',
        suffixIcon:
            controller.text.isNotEmpty ? _buildCancelSearchButton() : null,
        filled: true,
        fillColor: fillColor,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
      onChanged: (value) {
        setState(() {});
        context.read<OrganizerProvider>().filter(value);
      },
    );
  }

  Widget _buildCancelSearchButton() {
    return IconButton(
      key: Key('$SearchBar.CancelSearchButton'),
      icon: const Icon(Icons.close),
      splashRadius: 20,
      onPressed: () {
        setState(
          () {
            controller = TextEditingController();
          },
        );

        context.read<OrganizerProvider>().resetFilter();
      },
    );
  }
}
