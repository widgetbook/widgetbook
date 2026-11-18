import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class ResponsiveImage extends StatelessWidget {
  const ResponsiveImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        url,
        height: 200.h,
        width: 200.w,
      ),
    );
  }
}
