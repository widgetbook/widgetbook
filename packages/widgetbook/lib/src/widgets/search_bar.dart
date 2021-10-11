import 'package:flutter/material.dart';
import 'package:widgetbook/src/providers/organizer_provider.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';
import 'package:widgetbook/src/utils/utils.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context)!.state;
    final fillColor =
        theme == ThemeMode.light ? Styles.lightSurface : Styles.darkSurface;
    final onFillColor =
        theme == ThemeMode.light ? Styles.onLightSurface : Styles.onDarkSurface;

    const border = OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: canvasBorderRadius);

    return TextField(
      controller: controller,
      cursorWidth: 3,
      cursorColor: onFillColor,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'search',
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close),
                splashRadius: 20,
                onPressed: () {
                  setState(
                    () {
                      controller = TextEditingController();
                    },
                  );

                  OrganizerProvider.of(context)!.resetFilter();
                },
              )
            : null,
        filled: true,
        fillColor: fillColor,
        enabledBorder: border,
        focusedBorder: border,
      ),
      onChanged: (value) {
        OrganizerProvider.of(context)!.filter(
          RegExp(value),
        );
      },
    );
  }
}
