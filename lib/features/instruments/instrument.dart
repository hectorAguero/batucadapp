import 'package:dart_mappable/dart_mappable.dart';

part 'instrument.mapper.dart';

@MappableClass()
class Instrument with InstrumentMappable {
  const Instrument({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUri,
    required this.gallery,
    required this.type,
    required this.translatedName,
    required this.translatedDescription,
  });

  final int id;
  final String name;
  final String type;
  final String description;
  final String imageUri;
  final List<String> gallery;
  final String translatedName;
  final String translatedDescription;

  static const fromMap = InstrumentMapper.fromMap;
  static const fromJson = InstrumentMapper.fromJson;
}
