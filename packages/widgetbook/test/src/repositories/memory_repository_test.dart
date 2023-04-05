import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/repositories/memory_repository.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@immutable
class _Item extends Model {
  const _Item({
    required super.id,
    required this.value,
  });

  final int value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _Item && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _MemoryRepository extends MemoryRepository<_Item> {
  _MemoryRepository({super.initialConfiguration});

  Map<String, _Item> getMemory() {
    return memory;
  }
}

void main() {
  const defaultId = '1';
  const alternateId = '2';

  group(
    '$MemoryRepository',
    () {
      test(
        'adds item when addItem is called',
        () async {
          final repository = _MemoryRepository();
          final stream = repository.getStreamOfItems();

          expect(
            stream,
            emitsInOrder(
              <dynamic>[
                <_Item>[],
                <_Item>[
                  const _Item(
                    id: defaultId,
                    value: 0,
                  ),
                ],
                emitsDone,
              ],
            ),
          );

          repository.addItem(
            const _Item(
              id: defaultId,
              value: 0,
            ),
          );
          await repository.closeStream();

          expect(
            repository.memory,
            equals(
              <String, _Item>{
                defaultId: const _Item(
                  id: defaultId,
                  value: 0,
                ),
              },
            ),
          );
        },
      );

      test(
        'removes item when deleteItem is called',
        () async {
          final repository = _MemoryRepository(
            initialConfiguration: <String, _Item>{
              defaultId: const _Item(
                id: defaultId,
                value: 0,
              ),
            },
          );
          final stream = repository.getStreamOfItems();

          expect(
            stream,
            emitsInOrder(
              <dynamic>[
                <_Item>[
                  const _Item(
                    id: defaultId,
                    value: 0,
                  ),
                ],
                <_Item>[],
                emitsDone,
              ],
            ),
          );

          repository.deleteItem(
            const _Item(
              id: defaultId,
              value: 0,
            ),
          );
          await repository.closeStream();

          expect(
            repository.memory,
            equals(
              <String, _Item>{},
            ),
          );
        },
      );

      test(
        'changes existing item when setItem is called',
        () async {
          final repository = _MemoryRepository(
            initialConfiguration: <String, _Item>{
              defaultId: const _Item(
                id: defaultId,
                value: 0,
              ),
            },
          );
          final stream = repository.getStreamOfItems();

          expect(
            stream,
            emitsInOrder(
              <dynamic>[
                <_Item>[
                  const _Item(
                    id: defaultId,
                    value: 0,
                  ),
                ],
                <_Item>[
                  const _Item(
                    id: defaultId,
                    value: 1,
                  ),
                ],
                emitsDone,
              ],
            ),
          );

          repository.setItem(
            const _Item(
              id: defaultId,
              value: 1,
            ),
          );
          await repository.closeStream();

          expect(
            repository.memory,
            equals(
              <String, _Item>{
                defaultId: const _Item(
                  id: defaultId,
                  value: 1,
                ),
              },
            ),
          );
        },
      );

      test(
        'adds item when setItem is called',
        () async {
          final repository = _MemoryRepository();
          final stream = repository.getStreamOfItems();

          expect(
            stream,
            emitsInOrder(
              <dynamic>[
                <_Item>[],
                <_Item>[
                  const _Item(
                    id: defaultId,
                    value: 0,
                  ),
                ],
                emitsDone,
              ],
            ),
          );

          repository.setItem(
            const _Item(
              id: defaultId,
              value: 0,
            ),
          );
          await repository.closeStream();

          expect(
            repository.memory,
            equals(
              <String, _Item>{
                defaultId: const _Item(
                  id: defaultId,
                  value: 0,
                ),
              },
            ),
          );
        },
      );

      test(
        'returns true when doesItemExist is called with item in memory',
        () async {
          final repository = _MemoryRepository(
            initialConfiguration: <String, _Item>{
              defaultId: const _Item(
                id: defaultId,
                value: 0,
              ),
            },
          );

          final result = repository.doesItemExist(defaultId);
          expect(
            result,
            isTrue,
          );
        },
      );

      test(
        'returns false when doesItemExist is called with item not in memory',
        () async {
          final repository = _MemoryRepository();

          final result = repository.doesItemExist(defaultId);
          expect(
            result,
            false,
          );
        },
      );

      test(
        'returns item when getItem is called',
        () async {
          final repository = _MemoryRepository(
            initialConfiguration: <String, _Item>{
              defaultId: const _Item(
                id: defaultId,
                value: 0,
              ),
            },
          );

          final result = repository.getItem(defaultId);
          expect(
            result,
            equals(
              const _Item(
                id: defaultId,
                value: 0,
              ),
            ),
          );
        },
      );

      test(
        'removes all items when deleteAll is called',
        () async {
          final repository = _MemoryRepository(
            initialConfiguration: <String, _Item>{
              defaultId: const _Item(
                id: defaultId,
                value: 0,
              ),
              alternateId: const _Item(
                id: alternateId,
                value: 1,
              ),
            },
          );
          final stream = repository.getStreamOfItems();

          expect(
            stream,
            emitsInOrder(
              <dynamic>[
                <_Item>[
                  const _Item(
                    id: defaultId,
                    value: 0,
                  ),
                  const _Item(
                    id: alternateId,
                    value: 1,
                  ),
                ],
                <_Item>[],
                emitsDone,
              ],
            ),
          );

          repository.deleteAll();
          await repository.closeStream();

          expect(
            repository.memory,
            equals(
              <String, _Item>{},
            ),
          );
        },
      );

      test(
        'removes all items when deleteAll is called',
        () async {
          final repository = _MemoryRepository();
          final stream = repository.getStreamOfItems();

          expect(
            stream,
            emitsInOrder(
              <dynamic>[
                <_Item>[],
                <_Item>[
                  const _Item(
                    id: defaultId,
                    value: 0,
                  ),
                  const _Item(
                    id: alternateId,
                    value: 1,
                  ),
                ],
                emitsDone,
              ],
            ),
          );

          repository.addAll([
            const _Item(
              id: defaultId,
              value: 0,
            ),
            const _Item(
              id: alternateId,
              value: 1,
            ),
          ]);
          await repository.closeStream();

          expect(
            repository.memory,
            equals(
              <String, _Item>{
                defaultId: const _Item(
                  id: defaultId,
                  value: 0,
                ),
                alternateId: const _Item(
                  id: alternateId,
                  value: 1,
                ),
              },
            ),
          );
        },
      );
    },
  );
}
