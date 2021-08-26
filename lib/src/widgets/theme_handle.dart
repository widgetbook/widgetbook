import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook/src/cubit/theme/theme_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/extensions.dart';

class ThemeHandle extends StatelessWidget {
  const ThemeHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return Row(
          children: [
            // TODO add an own widget for this
            // or style the text button.icon appropriately
            // TODO make sure the onPresses is triggered on the text as well
            TextButton(
              onPressed: context.read<ThemeCubit>().toggleTheme,
              style: TextButton.styleFrom(
                splashFactory: InkRipple.splashFactory,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90)),
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(12),
              ),
              child: Icon(
                FontAwesomeIcons.moon,
                color: context.read<ThemeCubit>().state == ThemeMode.light
                    ? context.theme.hintColor
                    : context.colorScheme.primary,
                size: 16,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Text('theme'),
          ],
        );
      },
    );
  }
}
