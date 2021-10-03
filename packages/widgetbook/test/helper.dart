import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpWidgetWithMaterialApp(
    Widget widget,
  ) async {
    return this.pumpWidget(
      MaterialApp(
        home: widget,
      ),
    );
  }

  Future<Provider> pumpBuilderAndReturnProvider<Provider>(Widget widget) async {
    await pumpWidgetWithMaterialApp(widget);
    var providerFinder = find.byType(Provider);
    expect(providerFinder, findsOneWidget);

    var provider = this.firstWidget(providerFinder) as Provider;
    return provider;
  }

  Future<T> invokeMethodAndReturnPumpedProvider<T>(
    VoidCallback method,
  ) async {
    method();
    await this.pumpAndSettle();
    return getProvider<T>();
  }

  // TODO T has to be a provider
  T getProvider<T>() {
    var providerFinder = find.byType(T);
    return this.firstWidget(providerFinder) as T;
  }
}
