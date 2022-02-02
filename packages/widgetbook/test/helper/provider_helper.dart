import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_test_helper.dart';

extension ProviderTesterExtension on WidgetTester {
  Future<Provider> pumpBuilderAndReturnProvider<Provider>(Widget widget) async {
    await pumpWidgetWithMaterialApp(widget);
    final providerFinder = find.byType(Provider);
    expect(providerFinder, findsOneWidget);

    final provider = firstWidget(providerFinder) as Provider;
    return provider;
  }

  Future<T> invokeMethodAndReturnPumpedProvider<T>(
    VoidCallback method,
  ) async {
    method();
    await pumpAndSettle();
    return getProvider<T>();
  }

  T getProvider<T>() {
    final providerFinder = find.byType(T);
    return firstWidget(providerFinder) as T;
  }
}
