import 'package:flutter/material.dart';

import '../layout/desktop_layout.dart';
import '../layout/mobile_layout.dart';

class WidgetbookShell extends StatelessWidget {
  const WidgetbookShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 800;

    return isMobile
        ? MobileWidgetbookShell(child: child)
        : DesktopWidgetbookShell(child: child);
  }
}
