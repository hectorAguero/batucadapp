import 'package:dart_mappable/dart_mappable.dart';

part 'instrument.mapper.dart';

@MappableClass()
class Instrument with InstrumentMappable {
  const Instrument({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.details,
  });

  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String? details;
}
