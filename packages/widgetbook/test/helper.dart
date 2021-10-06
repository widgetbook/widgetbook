import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpWidgetWithMaterialApp(
    Widget widget,
  ) async {
    return pumpWidget(
      MaterialApp(
        home: widget,
      ),
    );
  }

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

  // TODO T has to be a provider
  T getProvider<T>() {
    final providerFinder = find.byType(T);
    return firstWidget(providerFinder) as T;
  }
}
