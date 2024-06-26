// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'instrument.dart';

class InstrumentMapper extends ClassMapperBase<Instrument> {
  InstrumentMapper._();

  static InstrumentMapper? _instance;
  static InstrumentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InstrumentMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Instrument';

  static int _$id(Instrument v) => v.id;
  static const Field<Instrument, int> _f$id = Field('id', _$id);
  static String _$name(Instrument v) => v.name;
  static const Field<Instrument, String> _f$name = Field('name', _$name);
  static String _$description(Instrument v) => v.description;
  static const Field<Instrument, String> _f$description =
      Field('description', _$description);
  static String _$imageUrl(Instrument v) => v.imageUrl;
  static const Field<Instrument, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl);
  static IList<String> _$gallery(Instrument v) => v.gallery;
  static const Field<Instrument, IList<String>> _f$gallery =
      Field('gallery', _$gallery);
  static String _$type(Instrument v) => v.type;
  static const Field<Instrument, String> _f$type = Field('type', _$type);
  static String _$translatedName(Instrument v) => v.translatedName;
  static const Field<Instrument, String> _f$translatedName =
      Field('translatedName', _$translatedName);
  static String _$translatedDescription(Instrument v) =>
      v.translatedDescription;
  static const Field<Instrument, String> _f$translatedDescription =
      Field('translatedDescription', _$translatedDescription);

  @override
  final MappableFields<Instrument> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #imageUrl: _f$imageUrl,
    #gallery: _f$gallery,
    #type: _f$type,
    #translatedName: _f$translatedName,
    #translatedDescription: _f$translatedDescription,
  };

  static Instrument _instantiate(DecodingData data) {
    return Instrument(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        imageUrl: data.dec(_f$imageUrl),
        gallery: data.dec(_f$gallery),
        type: data.dec(_f$type),
        translatedName: data.dec(_f$translatedName),
        translatedDescription: data.dec(_f$translatedDescription));
  }

  @override
  final Function instantiate = _instantiate;

  static Instrument fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Instrument>(map);
  }

  static Instrument fromJson(String json) {
    return ensureInitialized().decodeJson<Instrument>(json);
  }
}

mixin InstrumentMappable {
  String toJson() {
    return InstrumentMapper.ensureInitialized()
        .encodeJson<Instrument>(this as Instrument);
  }

  Map<String, dynamic> toMap() {
    return InstrumentMapper.ensureInitialized()
        .encodeMap<Instrument>(this as Instrument);
  }

  InstrumentCopyWith<Instrument, Instrument, Instrument> get copyWith =>
      _InstrumentCopyWithImpl(this as Instrument, $identity, $identity);
  @override
  String toString() {
    return InstrumentMapper.ensureInitialized()
        .stringifyValue(this as Instrument);
  }

  @override
  bool operator ==(Object other) {
    return InstrumentMapper.ensureInitialized()
        .equalsValue(this as Instrument, other);
  }

  @override
  int get hashCode {
    return InstrumentMapper.ensureInitialized().hashValue(this as Instrument);
  }
}

extension InstrumentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Instrument, $Out> {
  InstrumentCopyWith<$R, Instrument, $Out> get $asInstrument =>
      $base.as((v, t, t2) => _InstrumentCopyWithImpl(v, t, t2));
}

abstract class InstrumentCopyWith<$R, $In extends Instrument, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      String? name,
      String? description,
      String? imageUrl,
      IList<String>? gallery,
      String? type,
      String? translatedName,
      String? translatedDescription});
  InstrumentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _InstrumentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Instrument, $Out>
    implements InstrumentCopyWith<$R, Instrument, $Out> {
  _InstrumentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Instrument> $mapper =
      InstrumentMapper.ensureInitialized();
  @override
  $R call(
          {int? id,
          String? name,
          String? description,
          String? imageUrl,
          IList<String>? gallery,
          String? type,
          String? translatedName,
          String? translatedDescription}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (imageUrl != null) #imageUrl: imageUrl,
        if (gallery != null) #gallery: gallery,
        if (type != null) #type: type,
        if (translatedName != null) #translatedName: translatedName,
        if (translatedDescription != null)
          #translatedDescription: translatedDescription
      }));
  @override
  Instrument $make(CopyWithData data) => Instrument(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      gallery: data.get(#gallery, or: $value.gallery),
      type: data.get(#type, or: $value.type),
      translatedName: data.get(#translatedName, or: $value.translatedName),
      translatedDescription:
          data.get(#translatedDescription, or: $value.translatedDescription));

  @override
  InstrumentCopyWith<$R2, Instrument, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _InstrumentCopyWithImpl($value, $cast, t);
}
