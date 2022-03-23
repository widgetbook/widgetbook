import 'package:flutter/material.dart';
import 'package:widgetbook/src/app_info/app_info.dart';
import 'package:widgetbook/src/constants/constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.appInfo,
  }) : super(key: key);

  final AppInfo appInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
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
