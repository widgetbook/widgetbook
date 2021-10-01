import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/repositories/memory_repository.dart';
import 'package:widgetbook/src/models/model.dart';

class _Item extends Model {
  _Item(
    String id,
  ) : super(
          id: id,
        );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _Item && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _MemoryRepository extends MemoryRepository<_Item> {
  _MemoryRepository({Map<String, _Item>? initialConfiguration})
      : super(
          initialConfiguration: initialConfiguration,
        );

  Map<String, _Item> getMemory() {
    return memory;
  }
}

void main() {
  String defaultId = '1';

  group('$MemoryRepository', () {
    test(
      'adds item when addItem is called',
      () {
        var repository = _MemoryRepository();
        repository.addItem(
          _Item(defaultId),
        );

        expect(
          repository.memory,
          equals(
            <String, _Item>{
              defaultId: _Item(defaultId),
            },
          ),
        );
      },
    );
  });
}
