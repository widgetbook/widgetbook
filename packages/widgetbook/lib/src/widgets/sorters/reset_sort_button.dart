import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';

class ResetSortButton extends StatelessWidget {
  const ResetSortButton({
    Key? key,
    this.size = 17.0,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Remove sorting',
      child: InkWell(
        customBorder: const CircleBorder(),
        hoverColor: Theme.of(context).cardColor,
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Icon(
            Icons.close,
            size: size,
          ),
        ),
        onTap: () => context.read<OrganizerProvider>().resetSort(),
      ),
    );
  }
}
