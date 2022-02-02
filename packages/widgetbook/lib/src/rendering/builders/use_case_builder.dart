import 'package:flutter/material.dart';

UseCaseBuilderFunction get defaultUseCaseBuilder =>
    (BuildContext context, Widget child) {
      return child;
    };

typedef UseCaseBuilderFunction = Widget Function(
  BuildContext context,
  Widget child,
);
