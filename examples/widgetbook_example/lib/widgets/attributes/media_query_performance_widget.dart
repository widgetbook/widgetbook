import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'attribute.dart';

class MediaQueryPerformanceWidget extends StatelessWidget {
  const MediaQueryPerformanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Attribute(
      attribute:
          'Screen Widget ${MediaQuery.of(context).size.width} - Screen Height ${MediaQuery.of(context).size.height}',
      iconData: FontAwesomeIcons.phoneSquareAlt,
    );
  }
}
