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
        var repository = _ValueRepository();

        expect(
          repository.getCurrentValue(),
          isNull,
        );
      },
    );

    test(
      'has initial when created with named constructor',
      () {
        var repository = _ValueRepository(item: 0);

        expect(
          repository.getCurrentValue(),
          equals(0),
        );
      },
    );

    test(
      'sets item when setItem is called',
      () {
        var repository = _ValueRepository();
        repository.setItem(0);

        expect(
          repository.getCurrentValue(),
          equals(0),
        );
      },
    );

    test(
      'gets item when getItem is called',
      () {
        var repository = _ValueRepository(item: 0);

        expect(
          repository.getItem(),
          equals(0),
        );
      },
    );

    test(
      'sets item to null when deleteItem is called',
      () {
        var repository = _ValueRepository(item: 0);
        repository.deleteItem();

        expect(
          repository.getCurrentValue(),
          isNull,
        );
      },
    );

    test(
      'returns true when isSet is called with a set value',
      () {
        var repository = _ValueRepository(item: 0);

        expect(
          repository.isSet(),
          isTrue,
        );
      },
    );

    test(
      'returns true when isSet is called with a set value',
      () {
        var repository = _ValueRepository();

        expect(
          repository.isSet(),
          isFalse,
        );
      },
    );

    test(
      'returns done when getStream is called and then closed',
      () async {
        var repository = _ValueRepository();
        var stream = repository.getStream();

        expect(
          stream,
          emitsDone,
        );

        repository.closeStream();
      },
    );

    test(
      '.getStream emits value when setItem is called',
      () async {
        var repository = _ValueRepository();
        var stream = repository.getStream();

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
        repository.closeStream();
      },
    );

    test(
      '.getStream emits null when deleteItem is called',
      () async {
        var repository = _ValueRepository(item: 0);
        var stream = repository.getStream();

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
        repository.closeStream();
      },
    );
  });
}
