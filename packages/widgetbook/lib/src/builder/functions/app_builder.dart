import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/src/builder/builder.dart';
import 'package:widgetbook/widgetbook.dart';

AppBuilderFunction get materialAppBuilder =>
    (BuildContext context, Widget child) {
      final builder = Builder(
        builder: (context) {
          return MaterialApp(
            theme: context.materialTheme,
            locale: context.localization?.activeLocale,
            supportedLocales: context.localization?.supportedLocales ??
                const <Locale>[
                  Locale('en', 'US'),
                ],
            localizationsDelegates:
                context.localization?.localizationsDelegates,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: context.textScale,
                ),
                child: child,
              ),
            ),
          );
        },
      );
      final frameBuilder = context.frameBuilder;
      return frameBuilder == null
          ? builder
          : frameBuilder(
              context,
              builder,
            );
    };

AppBuilderFunction get cupertinoAppBuilder =>
    (BuildContext context, Widget child) {
      final builder = Builder(
        builder: (context) {
          return CupertinoApp(
            theme: context.cupertinoTheme,
            locale: context.localization?.activeLocale,
            supportedLocales: context.localization?.supportedLocales ??
                const <Locale>[
                  Locale('en', 'US'),
                ],
            localizationsDelegates:
                context.localization?.localizationsDelegates,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: context.textScale,
                ),
                child: child,
              ),
            ),
          );
        },
      );
      final frameBuilder = context.frameBuilder;
      return frameBuilder == null
          ? builder
          : frameBuilder(
              context,
              builder,
            );
    };
