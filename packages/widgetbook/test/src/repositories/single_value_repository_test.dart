import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/repositories/single_value_repository.dart';

class _SingleValueTestRepository extends SingleValueRepository<int> {
  _SingleValueTestRepository({
    int? item,
  }) : super(item: item);

  int? getCurrentValue() {
    return item;
  }
}

void main() {
  group('$SingleValueRepository', () {
    test(
      'has no value when created with empty constructor',
      () {
        var repository = _SingleValueTestRepository();

        expect(
          repository.getCurrentValue(),
          isNull,
        );
      },
    );

    test(
      'has initial when created with named constructor',
      () {
        var repository = _SingleValueTestRepository(item: 0);

        expect(
          repository.getCurrentValue(),
          equals(0),
        );
      },
    );

    test(
      'sets item when setItem is called',
      () {
        var repository = _SingleValueTestRepository();
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
        var repository = _SingleValueTestRepository(item: 0);

        expect(
          repository.getItem(),
          equals(0),
        );
      },
    );

    test(
      'sets item to null when deleteItem is called',
      () {
        var repository = _SingleValueTestRepository(item: 0);
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
        var repository = _SingleValueTestRepository(item: 0);

        expect(
          repository.isSet(),
          isTrue,
        );
      },
    );

    test(
      'returns true when isSet is called with a set value',
      () {
        var repository = _SingleValueTestRepository();

        expect(
          repository.isSet(),
          isFalse,
        );
      },
    );

    test(
      'returns a stream with a null value when getStream is called',
      () async {
        var repository = _SingleValueTestRepository();
        var stream = repository.getStream();

        expect(
          stream,
          isNotEmpty,
        );

        expect(
          await stream.first,
          isNull,
        );
      },
    );

    test(
      '.getStream emits value when setItem is called',
      () async {
        var repository = _SingleValueTestRepository();
        var stream = repository.getStream();
        repository.setItem(0);

        expect(
          stream,
          contains(0),
        );
      },
    );

    test(
      '.getStream emits value when deleteItem is called',
      () async {
        var repository = _SingleValueTestRepository(item: 0);
        var stream = repository.getStream();
        repository.deleteItem();

        expect(
          stream,
          containsAllInOrder(
            [
              0,
              null,
            ],
          ),
        );
      },
    );
  });
}
