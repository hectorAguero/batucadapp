import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart'
    as ic;

typedef ImmutableList<T> = IList<T>;
typedef IList<T> = ic.IList<T>;

void initializeFICMappers() {
  // This makes all mappers work with immutable collections
  MapperContainer.globals.useAll([
    // mapper for immutable lists
    SerializableMapper<ImmutableList<dynamic>, Object>.arg1(
      decode: ImmutableList.fromJson,
      encode: (list) => list.toJson,
      type: <E>(f) => f<ImmutableList<E>>(),
    ),
  ]);
}

// ignore: prefer_match_file_name
extension ListX<T> on List<T> {
  ImmutableList<T> get toImmutable => ImmutableList<T>(this);
}
