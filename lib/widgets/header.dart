import 'package:flutter/material.dart';
import 'package:widgetbook/constants/constants.dart';
import 'package:widgetbook/models/app_info.dart';

class Header extends StatelessWidget {
  final AppInfo appInfo;
  const Header({
    Key? key,
    required this.appInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      height: Constants.controlBarHeight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          appInfo.name,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
