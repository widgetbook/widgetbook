import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:widgetbook_example/constants/color.dart';

class NewTag extends StatelessWidget {
  const NewTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: Text(
        AppLocalizations.of(context)!.newTag,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
