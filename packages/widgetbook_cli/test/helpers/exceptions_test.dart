import 'package:test/test.dart';

import '../../bin/helpers/helpers.dart';

void main() {
  group('Exceptions', () {
    group('$WidgetbookDeployException', () {
      test('has the correct message', () {
        const message = 'An error occurred while deploying your Widgetbook to '
            'Widgetbook Cloud. Please try again.';
        expect(WidgetbookDeployException().message, equals(message));
      });
    });

    group('$WidgetbookPublishReviewException', () {
      test('has the correct message', () {
        const message = 'An error occurred while deploying your Widgetbook '
            'review to Widgetbook Cloud. Please try again.';
        expect(WidgetbookPublishReviewException().message, equals(message));
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
            'An Error occured while uploading the build to Widgetbook Cloud.';
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
