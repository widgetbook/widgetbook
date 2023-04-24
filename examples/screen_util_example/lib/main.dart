import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// An example [Widget] that uses [ScreenUtil].
class ScreenUtilExample extends StatelessWidget {
  const ScreenUtilExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Scale height: ${ScreenUtil().screenHeight}',
            style: TextStyle(fontSize: 40.sp),
          ),
          Text(
            'Scale width: ${ScreenUtil().screenWidth}',
            style: TextStyle(fontSize: 40.sp),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'show screen height and width',
  type: ScreenUtilExample,
)
Widget exampleBuilder(BuildContext context) {
  return const ScreenUtilExample();
}

/// Customize your appBuilder function so the [ScreenUtilInit] widget is
/// injected into the [Widget] tree.
///
/// For more context on how to create the app builder see [materialAppBuilder]
/// or have a look at the documentation.
@widgetbook.AppBuilder()
Widget appBuilder(BuildContext context, Widget child) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    // This is needed to use the workbench [MediaQuery]
    useInheritedMediaQuery: true,
    builder: (context, child) {
      return MaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        home: child,
      );
    },
    child: child,
  );
}

/// The main method of the [App].
///
/// Note: This method is not the method to start the Widgetbook
void main() {
  runApp(const App());
}

/// [App] is just an abstract representation of what you App might look like.
///
/// Note: The [WidgetbookApp] annotation can used on ANY code element.
/// For more information, see the documentation
@widgetbook.App.material(
  // Adding devices is mandatory as it enables the [DeviceAddon] that is
  // required to properly set [MediaQuery] parameters
  devices: [
    Apple.iPhone13,
  ],
)
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: Placeholder()),
    );
  }
}
