import 'dart:io';

import '../../../widgetbook_cli.dart';

class UserInputValidityChecker {
  UserInputValidityChecker();

  /// Checks if the [package] directory is a Flutter project root directory.
  /// By checking for the presence of a pubspec.yaml file
  /// and Flutter dependency in the pubspec.yaml file.

  bool isPackage(
    String package, {
    String? widgetsTarget,
  }) {
    final pubspecFile = File('$package/pubspec.yaml').absolute;

    // Check if pubspec.yaml exists
    if (!pubspecFile.existsSync()) {
      throw InvalidFlutterPackageException(
        message:
            'pubspec.yaml file is missing for --package option $package, please provide a valid Flutter project root directory.',
      );
    }

    // Read the contents of pubspec.yaml
    final pubspecContent = pubspecFile.readAsStringSync();

    // Check for the presence of 'flutter' in the pubspec.yaml file
    if (!pubspecContent.contains('flutter:')) {
      throw InvalidFlutterPackageException(
        message:
            'Flutter dependency is missing for --package option $package, please provide a valid Flutter project root directory.',
      );
    }

    if (!(widgetsTarget?.contains(package) ?? true)) {
      throw InvalidFlutterPackageException(
        message:
            'The package and widgets_target options should point to the same project. The package project is $package and the widgets_target project is $widgetsTarget.',
      );
    }

    return true;
  }

  /// Checks if the [widgetbook] directory is a valid widgetbook project.
  /// By checking for the presence of a pubspec.yaml file
  /// and widgetbook dependency in the pubspec.yaml file.
  /// If the [widgetbook] is different from the [package],
  /// it checks if the widgetbook project imports the flutter project in the
  /// [package] directory.
  bool isValidWidgetbook(
    String widgetbook,
    String package, {
    String? widgetbookUsecasesTarget,
  }) {
    final packageName = File('$package/pubspec.yaml')
        .readAsStringSync()
        .split('\n')
        .firstWhere((line) => line.contains('name:'))
        .split(':')
        .last
        .trim()
        .replaceAll(RegExp(r'''^[\'"]|[\'"]$'''), '');

    final pubspecFile = File('$widgetbook/pubspec.yaml');

    // Check if pubspec.yaml exists
    if (!pubspecFile.existsSync()) {
      throw InvalidWidgetbookPackageException(
        message:
            'pubspec.yaml file is missing for --widgetbook option $widgetbook, please provide a valid Widgetbook project root directory.',
      );
    }

    // Read the contents of pubspec.yaml
    final pubspecContent = pubspecFile.readAsStringSync();

    // Check for the presence of 'widgetbook' in the pubspec.yaml file
    if (!pubspecContent.contains('widgetbook:')) {
      throw InvalidWidgetbookPackageException(
        message:
            'Widgetbook dependency is missing for --widgetbook option $widgetbook, please provide a valid Widgetbook project root directory.',
      );
    }

    // if widgetbook context is a different project, check if the widgetbook
    // project imports the flutter project
    if (widgetbook != package) {
      if (!pubspecContent.contains('$packageName:')) {
        throw InvalidWidgetbookPackageException(
          message:
              'The widgetbook project for --widgetbook option $widgetbook does not depend on the Flutter project $packageName. Widgetbook project should depend on the Flutter project.',
        );
      }
    }

    if (!(widgetbookUsecasesTarget?.contains(widgetbook) ?? true)) {
      throw InvalidWidgetbookPackageException(
        message:
            'The widgetbook and widgetbook_usecases_target options should point to the same project. The widgetbook project is $widgetbook and the widgetbook_usecases_target project is $widgetbookUsecasesTarget.',
      );
    }

    return true;
  }

  /// Checks if the provided path is a valid directory.
  bool isValidDirectory(
    String path, {
    required String option,
  }) {
    final directory = Directory(path);

    if (path.isEmpty) {
      throw FolderNotFoundException(
        message: 'Empty path argument is invalid for option --$option.',
      );
    }

    if (directory.statSync().type != FileSystemEntityType.directory) {
      throw FolderNotFoundException(
        message:
            'Path $path is not a valid folder directory for option --$option.',
      );
    }

    if (!directory.existsSync()) {
      throw FolderNotFoundException(
        message: 'Folder directory path $path is not found for --$option.',
      );
    }

    if (directory.listSync().isEmpty) {
      throw FolderNotFoundException(
        message:
            'Empty folder directory path $path cannot be set as target for option --$option.',
      );
    }

    return true;
  }
}
