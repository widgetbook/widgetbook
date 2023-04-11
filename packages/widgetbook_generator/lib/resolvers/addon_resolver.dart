import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_generator/extensions/element_extensions.dart';
import 'package:widgetbook_generator/json_formatter.dart';
import 'package:widgetbook_generator/models/widgetbook_addon_data.dart';

class AddonResolver
    extends GeneratorForAnnotation<WidgetbookAddonAnnotation<dynamic>> {
  @override
  String? generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element.isPrivate) {
      throw InvalidGenerationSourceError(
        'Widgetbook annotations cannot be applied to private classes',
        element: element,
      );
    }

    // TODO a list of todos
    // - check if this is annotated on a Addon
    // - check if this is annotated somewhere else (required for pre-defined addons)
    // - check if Type of annotation aligns with type of setting
    // - check if this code still works if the generic parameter is not dynamic

    // TODO make sure this nullcheck passes, otherwise throw error

    final settingName = annotation.read('setting').objectValue.variable!.name;

    final data = WidgetbookAddonData(
      name: element.name!,
      variableName: settingName,
      importStatement: element.importStatement,
    );

    return [data].toJson();
  }
}
