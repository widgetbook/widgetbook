import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/repositories/value_repository.dart';

class _ValueRepository extends ValueRepository<int> {
  _ValueRepository({
    int? item,
  }) : super(item: item);

  int? getCurrentValue() {
    return item;
  }
}

void main() {
  group('$ValueRepository', () {
    test(
      'has no value when created with empty constructor',
      () {
        final repository = _ValueRepository();

        expect(
          repository.getCurrentValue(),
          isNull,
        );
      },
    );

    test(
      'has initial when created with named constructor',
      () {
        final repository = _ValueRepository(item: 0);

        expect(
          repository.getCurrentValue(),
          equals(0),
        );
      },
    );

    test(
      'sets item when setItem is called',
      () {
        final repository = _ValueRepository()..setItem(0);

        expect(
          repository.getCurrentValue(),
          equals(0),
        );
      },
    );

    test(
      'gets item when getItem is called',
      () {
        final repository = _ValueRepository(item: 0);

        expect(
          repository.getItem(),
          equals(0),
        );
      },
    );

    test(
      'sets item to null when deleteItem is called',
      () {
        final repository = _ValueRepository(item: 0)..deleteItem();

        expect(
          repository.getCurrentValue(),
          isNull,
        );
      },
    );

    test(
      'returns true when isSet is called with a set value',
      () {
        final repository = _ValueRepository(item: 0);

        expect(
          repository.isSet(),
          isTrue,
        );
      },
    );

    test(
      'returns true when isSet is called with a set value',
      () {
        final repository = _ValueRepository();

        expect(
          repository.isSet(),
          isFalse,
        );
      },
    );

    test(
      'returns done when getStream is called and then closed',
      () async {
        final repository = _ValueRepository();
        final stream = repository.getStream();

        expect(
          stream,
          emitsDone,
        );

        await repository.closeStream();
      },
    );

    test(
      '.getStream emits value when setItem is called',
      () async {
        final repository = _ValueRepository();
        final stream = repository.getStream();

        expect(
          stream,
          emitsInOrder(
            <dynamic>[
              0,
              emitsDone,
            ],
          ),
        );

        repository.setItem(0);
        await repository.closeStream();
      },
    );

    test(
      '.getStream emits null when deleteItem is called',
      () async {
        final repository = _ValueRepository(item: 0);
        final stream = repository.getStream();

        expect(
          stream,
          emitsInOrder(
            <dynamic>[
              null,
              emitsDone,
            ],
          ),
        );

        repository.deleteItem();
        await repository.closeStream();
      },
    );
  });
}
