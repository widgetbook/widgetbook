import 'package:test/test.dart';

import 'package:widgetbook_cli/widgetbook_cli.dart';

class TestWidgetbookException extends WidgetbookException {
  TestWidgetbookException(super.message);
}

void main() {
  group('Exceptions', () {
    group('$WidgetbookException', () {
      late TestWidgetbookException sut;
      const message = 'Name is required';

      setUp(() {
        sut = TestWidgetbookException(message);
      });

      test('accepts message', () {
        expect(sut.message, equals(message));
      });

      test('ensure overrides toString() returns the message', () {
        expect(sut.toString(), equals(message));
      });
    });

    group('$DirectoryNotFoundException', () {
      test('has the correct message', () {
        const message = 'Directory ./ does not exist.';
        expect(
          DirectoryNotFoundException(message: message).message,
          equals(message),
        );
      });
    });

    group('$FileNotFoundException', () {
      test('has the correct message', () {
        const message = 'File does not exist.';
        expect(
          FileNotFoundException().message,
          equals(message),
        );
      });
    });

    group('$ActorNotFoundException', () {
      test('has the correct message', () {
        const message = 'Actor is a required parameter.';
        expect(
          ActorNotFoundException().message,
          equals(message),
        );
      });
    });

    group('$RepositoryNotFoundException', () {
      test('has the correct message', () {
        const message = 'Respository is a required parameter.';
        expect(
          RepositoryNotFoundException().message,
          equals(message),
        );
      });
    });

    group('$WidgetbookApiException', () {
      test('has the correct message', () {
        const message =
            'An Error occurred while uploading the build to Widgetbook Cloud.';
        expect(
          WidgetbookApiException().message,
          equals(message),
        );
      });
    });

    group('$UnableToCreateZipFileException', () {
      test('has the correct message', () {
        const message = 'Could not create .zip file for upload.';
        expect(
          UnableToCreateZipFileException().message,
          equals(message),
        );
      });
    });
  });
}
