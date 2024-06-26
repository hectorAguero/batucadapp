// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'school.dart';

class SchoolCategoryMapper extends EnumMapper<SchoolCategory> {
  SchoolCategoryMapper._();

  static SchoolCategoryMapper? _instance;
  static SchoolCategoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchoolCategoryMapper._());
    }
    return _instance!;
  }

  static SchoolCategory fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SchoolCategory decode(dynamic value) {
    switch (value) {
      case 'Escolas de samba':
        return SchoolCategory.escolasDeSamba;
      case 'Escolas mirins':
        return SchoolCategory.escolasMirins;
      case 'Blocos de enredo':
        return SchoolCategory.blocoDeEnredo;
      case 'Blocos de rua':
        return SchoolCategory.blocoDeRua;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SchoolCategory self) {
    switch (self) {
      case SchoolCategory.escolasDeSamba:
        return 'Escolas de samba';
      case SchoolCategory.escolasMirins:
        return 'Escolas mirins';
      case SchoolCategory.blocoDeEnredo:
        return 'Blocos de enredo';
      case SchoolCategory.blocoDeRua:
        return 'Blocos de rua';
    }
  }
}

extension SchoolCategoryMapperExtension on SchoolCategory {
  dynamic toValue() {
    SchoolCategoryMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SchoolCategory>(this);
  }
}

class SchoolDivisionMapper extends EnumMapper<SchoolDivision> {
  SchoolDivisionMapper._();

  static SchoolDivisionMapper? _instance;
  static SchoolDivisionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchoolDivisionMapper._());
    }
    return _instance!;
  }

  static SchoolDivision fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SchoolDivision decode(dynamic value) {
    switch (value) {
      case _SchoolDivisionConstants.especial:
        return SchoolDivision.especial;
      case _SchoolDivisionConstants.ouro:
        return SchoolDivision.ouro;
      case _SchoolDivisionConstants.prata:
        return SchoolDivision.prata;
      case _SchoolDivisionConstants.bronze:
        return SchoolDivision.bronze;
      case _SchoolDivisionConstants.avaliacao:
        return SchoolDivision.avaliacao;
      case _SchoolDivisionConstants.mirins:
        return SchoolDivision.mirins;
      case _SchoolDivisionConstants.blocosDeEnredo1:
        return SchoolDivision.blocosDeEnredo1;
      case _SchoolDivisionConstants.blocosDeEnredo2:
        return SchoolDivision.blocosDeEnredo2;
      case _SchoolDivisionConstants.blocosDeRua:
        return SchoolDivision.blocosDeRua;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SchoolDivision self) {
    switch (self) {
      case SchoolDivision.especial:
        return _SchoolDivisionConstants.especial;
      case SchoolDivision.ouro:
        return _SchoolDivisionConstants.ouro;
      case SchoolDivision.prata:
        return _SchoolDivisionConstants.prata;
      case SchoolDivision.bronze:
        return _SchoolDivisionConstants.bronze;
      case SchoolDivision.avaliacao:
        return _SchoolDivisionConstants.avaliacao;
      case SchoolDivision.mirins:
        return _SchoolDivisionConstants.mirins;
      case SchoolDivision.blocosDeEnredo1:
        return _SchoolDivisionConstants.blocosDeEnredo1;
      case SchoolDivision.blocosDeEnredo2:
        return _SchoolDivisionConstants.blocosDeEnredo2;
      case SchoolDivision.blocosDeRua:
        return _SchoolDivisionConstants.blocosDeRua;
    }
  }
}

extension SchoolDivisionMapperExtension on SchoolDivision {
  dynamic toValue() {
    SchoolDivisionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SchoolDivision>(this);
  }
}

class SchoolMapper extends ClassMapperBase<School> {
  SchoolMapper._();

  static SchoolMapper? _instance;
  static SchoolMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchoolMapper._());
      SchoolCategoryMapper.ensureInitialized();
      SchoolDivisionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'School';

  static int _$id(School v) => v.id;
  static const Field<School, int> _f$id = Field('id', _$id);
  static String _$name(School v) => v.name;
  static const Field<School, String> _f$name = Field('name', _$name);
  static String _$translatedName(School v) => v.translatedName;
  static const Field<School, String> _f$translatedName =
      Field('translatedName', _$translatedName);
  static String _$imageUrl(School v) => v.imageUrl;
  static const Field<School, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl);
  static DateTime? _$foundationDate(School v) => v.foundationDate;
  static const Field<School, DateTime> _f$foundationDate =
      Field('foundationDate', _$foundationDate, hook: DateTimeHook());
  static String _$godmotherSchool(School v) => v.godmotherSchool;
  static const Field<School, String> _f$godmotherSchool =
      Field('godmotherSchool', _$godmotherSchool);
  static IList<String> _$colors(School v) => v.colors;
  static const Field<School, IList<String>> _f$colors =
      Field('colors', _$colors);
  static IList<Color> _$colorsCode(School v) => v.colorsCode;
  static const Field<School, IList<Color>> _f$colorsCode =
      Field('colorsCode', _$colorsCode, key: 'colors', hook: SchoolColorHook());
  static IList<String> _$symbols(School v) => v.symbols;
  static const Field<School, IList<String>> _f$symbols =
      Field('symbols', _$symbols);
  static SchoolCategory _$carnivalCategory(School v) => v.carnivalCategory;
  static const Field<School, SchoolCategory> _f$carnivalCategory =
      Field('carnivalCategory', _$carnivalCategory);
  static SchoolDivision _$currentDivision(School v) => v.currentDivision;
  static const Field<School, SchoolDivision> _f$currentDivision =
      Field('currentDivision', _$currentDivision, key: 'divisionNumber');
  static int _$divisionNumber(School v) => v.divisionNumber;
  static const Field<School, int> _f$divisionNumber =
      Field('divisionNumber', _$divisionNumber);
  static int? _$subdivisionNumber(School v) => v.subdivisionNumber;
  static const Field<School, int> _f$subdivisionNumber =
      Field('subdivisionNumber', _$subdivisionNumber);
  static int _$firstDivisionChampionships(School v) =>
      v.firstDivisionChampionships;
  static const Field<School, int> _f$firstDivisionChampionships =
      Field('firstDivisionChampionships', _$firstDivisionChampionships);
  static String _$country(School v) => v.country;
  static const Field<School, String> _f$country = Field('country', _$country);
  static String _$leagueLocation(School v) => v.leagueLocation;
  static const Field<School, String> _f$leagueLocation =
      Field('leagueLocation', _$leagueLocation);
  static int _$lastPosition(School v) => v.lastPosition;
  static const Field<School, int> _f$lastPosition =
      Field('lastPosition', _$lastPosition);
  static IList<String> _$translatedColors(School v) => v.translatedColors;
  static const Field<School, IList<String>> _f$translatedColors =
      Field('translatedColors', _$translatedColors);
  static IList<String> _$translatedSymbols(School v) => v.translatedSymbols;
  static const Field<School, IList<String>> _f$translatedSymbols =
      Field('translatedSymbols', _$translatedSymbols);
  static String _$translatedGodmotherSchool(School v) =>
      v.translatedGodmotherSchool;
  static const Field<School, String> _f$translatedGodmotherSchool =
      Field('translatedGodmotherSchool', _$translatedGodmotherSchool);
  static String _$translatedLeagueLocation(School v) =>
      v.translatedLeagueLocation;
  static const Field<School, String> _f$translatedLeagueLocation =
      Field('translatedLeagueLocation', _$translatedLeagueLocation);
  static String _$translatedCountry(School v) => v.translatedCountry;
  static const Field<School, String> _f$translatedCountry =
      Field('translatedCountry', _$translatedCountry);

  @override
  final MappableFields<School> fields = const {
    #id: _f$id,
    #name: _f$name,
    #translatedName: _f$translatedName,
    #imageUrl: _f$imageUrl,
    #foundationDate: _f$foundationDate,
    #godmotherSchool: _f$godmotherSchool,
    #colors: _f$colors,
    #colorsCode: _f$colorsCode,
    #symbols: _f$symbols,
    #carnivalCategory: _f$carnivalCategory,
    #currentDivision: _f$currentDivision,
    #divisionNumber: _f$divisionNumber,
    #subdivisionNumber: _f$subdivisionNumber,
    #firstDivisionChampionships: _f$firstDivisionChampionships,
    #country: _f$country,
    #leagueLocation: _f$leagueLocation,
    #lastPosition: _f$lastPosition,
    #translatedColors: _f$translatedColors,
    #translatedSymbols: _f$translatedSymbols,
    #translatedGodmotherSchool: _f$translatedGodmotherSchool,
    #translatedLeagueLocation: _f$translatedLeagueLocation,
    #translatedCountry: _f$translatedCountry,
  };

  static School _instantiate(DecodingData data) {
    return School(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        translatedName: data.dec(_f$translatedName),
        imageUrl: data.dec(_f$imageUrl),
        foundationDate: data.dec(_f$foundationDate),
        godmotherSchool: data.dec(_f$godmotherSchool),
        colors: data.dec(_f$colors),
        colorsCode: data.dec(_f$colorsCode),
        symbols: data.dec(_f$symbols),
        carnivalCategory: data.dec(_f$carnivalCategory),
        currentDivision: data.dec(_f$currentDivision),
        divisionNumber: data.dec(_f$divisionNumber),
        subdivisionNumber: data.dec(_f$subdivisionNumber),
        firstDivisionChampionships: data.dec(_f$firstDivisionChampionships),
        country: data.dec(_f$country),
        leagueLocation: data.dec(_f$leagueLocation),
        lastPosition: data.dec(_f$lastPosition),
        translatedColors: data.dec(_f$translatedColors),
        translatedSymbols: data.dec(_f$translatedSymbols),
        translatedGodmotherSchool: data.dec(_f$translatedGodmotherSchool),
        translatedLeagueLocation: data.dec(_f$translatedLeagueLocation),
        translatedCountry: data.dec(_f$translatedCountry));
  }

  @override
  final Function instantiate = _instantiate;

  static School fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<School>(map);
  }

  static School fromJson(String json) {
    return ensureInitialized().decodeJson<School>(json);
  }
}

mixin SchoolMappable {
  String toJson() {
    return SchoolMapper.ensureInitialized().encodeJson<School>(this as School);
  }

  Map<String, dynamic> toMap() {
    return SchoolMapper.ensureInitialized().encodeMap<School>(this as School);
  }

  SchoolCopyWith<School, School, School> get copyWith =>
      _SchoolCopyWithImpl(this as School, $identity, $identity);
  @override
  String toString() {
    return SchoolMapper.ensureInitialized().stringifyValue(this as School);
  }

  @override
  bool operator ==(Object other) {
    return SchoolMapper.ensureInitialized().equalsValue(this as School, other);
  }

  @override
  int get hashCode {
    return SchoolMapper.ensureInitialized().hashValue(this as School);
  }
}

extension SchoolValueCopy<$R, $Out> on ObjectCopyWith<$R, School, $Out> {
  SchoolCopyWith<$R, School, $Out> get $asSchool =>
      $base.as((v, t, t2) => _SchoolCopyWithImpl(v, t, t2));
}

abstract class SchoolCopyWith<$R, $In extends School, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      String? name,
      String? translatedName,
      String? imageUrl,
      DateTime? foundationDate,
      String? godmotherSchool,
      IList<String>? colors,
      IList<Color>? colorsCode,
      IList<String>? symbols,
      SchoolCategory? carnivalCategory,
      SchoolDivision? currentDivision,
      int? divisionNumber,
      int? subdivisionNumber,
      int? firstDivisionChampionships,
      String? country,
      String? leagueLocation,
      int? lastPosition,
      IList<String>? translatedColors,
      IList<String>? translatedSymbols,
      String? translatedGodmotherSchool,
      String? translatedLeagueLocation,
      String? translatedCountry});
  SchoolCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SchoolCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, School, $Out>
    implements SchoolCopyWith<$R, School, $Out> {
  _SchoolCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<School> $mapper = SchoolMapper.ensureInitialized();
  @override
  $R call(
          {int? id,
          String? name,
          String? translatedName,
          String? imageUrl,
          Object? foundationDate = $none,
          String? godmotherSchool,
          IList<String>? colors,
          IList<Color>? colorsCode,
          IList<String>? symbols,
          SchoolCategory? carnivalCategory,
          SchoolDivision? currentDivision,
          int? divisionNumber,
          Object? subdivisionNumber = $none,
          int? firstDivisionChampionships,
          String? country,
          String? leagueLocation,
          int? lastPosition,
          IList<String>? translatedColors,
          IList<String>? translatedSymbols,
          String? translatedGodmotherSchool,
          String? translatedLeagueLocation,
          String? translatedCountry}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (translatedName != null) #translatedName: translatedName,
        if (imageUrl != null) #imageUrl: imageUrl,
        if (foundationDate != $none) #foundationDate: foundationDate,
        if (godmotherSchool != null) #godmotherSchool: godmotherSchool,
        if (colors != null) #colors: colors,
        if (colorsCode != null) #colorsCode: colorsCode,
        if (symbols != null) #symbols: symbols,
        if (carnivalCategory != null) #carnivalCategory: carnivalCategory,
        if (currentDivision != null) #currentDivision: currentDivision,
        if (divisionNumber != null) #divisionNumber: divisionNumber,
        if (subdivisionNumber != $none) #subdivisionNumber: subdivisionNumber,
        if (firstDivisionChampionships != null)
          #firstDivisionChampionships: firstDivisionChampionships,
        if (country != null) #country: country,
        if (leagueLocation != null) #leagueLocation: leagueLocation,
        if (lastPosition != null) #lastPosition: lastPosition,
        if (translatedColors != null) #translatedColors: translatedColors,
        if (translatedSymbols != null) #translatedSymbols: translatedSymbols,
        if (translatedGodmotherSchool != null)
          #translatedGodmotherSchool: translatedGodmotherSchool,
        if (translatedLeagueLocation != null)
          #translatedLeagueLocation: translatedLeagueLocation,
        if (translatedCountry != null) #translatedCountry: translatedCountry
      }));
  @override
  School $make(CopyWithData data) => School(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      translatedName: data.get(#translatedName, or: $value.translatedName),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      foundationDate: data.get(#foundationDate, or: $value.foundationDate),
      godmotherSchool: data.get(#godmotherSchool, or: $value.godmotherSchool),
      colors: data.get(#colors, or: $value.colors),
      colorsCode: data.get(#colorsCode, or: $value.colorsCode),
      symbols: data.get(#symbols, or: $value.symbols),
      carnivalCategory:
          data.get(#carnivalCategory, or: $value.carnivalCategory),
      currentDivision: data.get(#currentDivision, or: $value.currentDivision),
      divisionNumber: data.get(#divisionNumber, or: $value.divisionNumber),
      subdivisionNumber:
          data.get(#subdivisionNumber, or: $value.subdivisionNumber),
      firstDivisionChampionships: data.get(#firstDivisionChampionships,
          or: $value.firstDivisionChampionships),
      country: data.get(#country, or: $value.country),
      leagueLocation: data.get(#leagueLocation, or: $value.leagueLocation),
      lastPosition: data.get(#lastPosition, or: $value.lastPosition),
      translatedColors:
          data.get(#translatedColors, or: $value.translatedColors),
      translatedSymbols:
          data.get(#translatedSymbols, or: $value.translatedSymbols),
      translatedGodmotherSchool: data.get(#translatedGodmotherSchool,
          or: $value.translatedGodmotherSchool),
      translatedLeagueLocation: data.get(#translatedLeagueLocation,
          or: $value.translatedLeagueLocation),
      translatedCountry:
          data.get(#translatedCountry, or: $value.translatedCountry));

  @override
  SchoolCopyWith<$R2, School, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SchoolCopyWithImpl($value, $cast, t);
}
