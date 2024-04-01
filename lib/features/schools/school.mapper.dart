// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'school.dart';

class SchoolLeagueMapper extends EnumMapper<SchoolLeague> {
  SchoolLeagueMapper._();

  static SchoolLeagueMapper? _instance;
  static SchoolLeagueMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchoolLeagueMapper._());
    }
    return _instance!;
  }

  static SchoolLeague fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SchoolLeague decode(dynamic value) {
    switch (value) {
      case 'LIESA':
        return SchoolLeague.liesa;
      case 'LIGARJ':
        return SchoolLeague.ligarj;
      case 'SUPERLIGA':
        return SchoolLeague.superliga;
      case 'ACAS':
        return SchoolLeague.acas;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SchoolLeague self) {
    switch (self) {
      case SchoolLeague.liesa:
        return 'LIESA';
      case SchoolLeague.ligarj:
        return 'LIGARJ';
      case SchoolLeague.superliga:
        return 'SUPERLIGA';
      case SchoolLeague.acas:
        return 'ACAS';
    }
  }
}

extension SchoolLeagueMapperExtension on SchoolLeague {
  String toValue() {
    SchoolLeagueMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SchoolLeague>(this) as String;
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
      case 1:
        return SchoolDivision.especial;
      case 2:
        return SchoolDivision.ouro;
      case 3:
        return SchoolDivision.prata;
      case 4:
        return SchoolDivision.bronze;
      case 5:
        return SchoolDivision.avaliacao;
      case 6:
        return SchoolDivision.mirins;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SchoolDivision self) {
    switch (self) {
      case SchoolDivision.especial:
        return 1;
      case SchoolDivision.ouro:
        return 2;
      case SchoolDivision.prata:
        return 3;
      case SchoolDivision.bronze:
        return 4;
      case SchoolDivision.avaliacao:
        return 5;
      case SchoolDivision.mirins:
        return 6;
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
      SchoolLeagueMapper.ensureInitialized();
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
  static DateTime _$foundationDate(School v) => v.foundationDate;
  static const Field<School, DateTime> _f$foundationDate =
      Field('foundationDate', _$foundationDate, hook: DateTimeHook());
  static String _$godmotherSchool(School v) => v.godmotherSchool;
  static const Field<School, String> _f$godmotherSchool =
      Field('godmotherSchool', _$godmotherSchool);
  static List<String> _$colorNames(School v) => v.colorNames;
  static const Field<School, List<String>> _f$colorNames =
      Field('colorNames', _$colorNames, key: 'colors');
  static List<Color> _$colors(School v) => v.colors;
  static const Field<School, List<Color>> _f$colors =
      Field('colors', _$colors, hook: ColorHook());
  static List<String> _$symbols(School v) => v.symbols;
  static const Field<School, List<String>> _f$symbols =
      Field('symbols', _$symbols);
  static SchoolLeague _$league(School v) => v.league;
  static const Field<School, SchoolLeague> _f$league =
      Field('league', _$league);
  static SchoolDivision _$currentDivision(School v) => v.currentDivision;
  static const Field<School, SchoolDivision> _f$currentDivision =
      Field('currentDivision', _$currentDivision, key: 'divisionNumber');
  static int _$divisionNumber(School v) => v.divisionNumber;
  static const Field<School, int> _f$divisionNumber =
      Field('divisionNumber', _$divisionNumber);
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
  static List<String> _$translatedColorNames(School v) =>
      v.translatedColorNames;
  static const Field<School, List<String>> _f$translatedColorNames = Field(
      'translatedColorNames', _$translatedColorNames,
      key: 'translatedColors');
  static List<String> _$translatedSymbols(School v) => v.translatedSymbols;
  static const Field<School, List<String>> _f$translatedSymbols =
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
  static bool _$isFavorite(School v) => v.isFavorite;
  static const Field<School, bool> _f$isFavorite =
      Field('isFavorite', _$isFavorite, opt: true, def: false);

  @override
  final MappableFields<School> fields = const {
    #id: _f$id,
    #name: _f$name,
    #translatedName: _f$translatedName,
    #imageUrl: _f$imageUrl,
    #foundationDate: _f$foundationDate,
    #godmotherSchool: _f$godmotherSchool,
    #colorNames: _f$colorNames,
    #colors: _f$colors,
    #symbols: _f$symbols,
    #league: _f$league,
    #currentDivision: _f$currentDivision,
    #divisionNumber: _f$divisionNumber,
    #firstDivisionChampionships: _f$firstDivisionChampionships,
    #country: _f$country,
    #leagueLocation: _f$leagueLocation,
    #lastPosition: _f$lastPosition,
    #translatedColorNames: _f$translatedColorNames,
    #translatedSymbols: _f$translatedSymbols,
    #translatedGodmotherSchool: _f$translatedGodmotherSchool,
    #translatedLeagueLocation: _f$translatedLeagueLocation,
    #translatedCountry: _f$translatedCountry,
    #isFavorite: _f$isFavorite,
  };

  static School _instantiate(DecodingData data) {
    return School(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        translatedName: data.dec(_f$translatedName),
        imageUrl: data.dec(_f$imageUrl),
        foundationDate: data.dec(_f$foundationDate),
        godmotherSchool: data.dec(_f$godmotherSchool),
        colorNames: data.dec(_f$colorNames),
        colors: data.dec(_f$colors),
        symbols: data.dec(_f$symbols),
        league: data.dec(_f$league),
        currentDivision: data.dec(_f$currentDivision),
        divisionNumber: data.dec(_f$divisionNumber),
        firstDivisionChampionships: data.dec(_f$firstDivisionChampionships),
        country: data.dec(_f$country),
        leagueLocation: data.dec(_f$leagueLocation),
        lastPosition: data.dec(_f$lastPosition),
        translatedColorNames: data.dec(_f$translatedColorNames),
        translatedSymbols: data.dec(_f$translatedSymbols),
        translatedGodmotherSchool: data.dec(_f$translatedGodmotherSchool),
        translatedLeagueLocation: data.dec(_f$translatedLeagueLocation),
        translatedCountry: data.dec(_f$translatedCountry),
        isFavorite: data.dec(_f$isFavorite));
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
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SchoolMapper.ensureInitialized()
                .isValueEqual(this as School, other));
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get colorNames;
  ListCopyWith<$R, Color, ObjectCopyWith<$R, Color, Color>> get colors;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get symbols;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get translatedColorNames;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get translatedSymbols;
  $R call(
      {int? id,
      String? name,
      String? translatedName,
      String? imageUrl,
      DateTime? foundationDate,
      String? godmotherSchool,
      List<String>? colorNames,
      List<Color>? colors,
      List<String>? symbols,
      SchoolLeague? league,
      SchoolDivision? currentDivision,
      int? divisionNumber,
      int? firstDivisionChampionships,
      String? country,
      String? leagueLocation,
      int? lastPosition,
      List<String>? translatedColorNames,
      List<String>? translatedSymbols,
      String? translatedGodmotherSchool,
      String? translatedLeagueLocation,
      String? translatedCountry,
      bool? isFavorite});
  SchoolCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SchoolCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, School, $Out>
    implements SchoolCopyWith<$R, School, $Out> {
  _SchoolCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<School> $mapper = SchoolMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get colorNames =>
      ListCopyWith($value.colorNames, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(colorNames: v));
  @override
  ListCopyWith<$R, Color, ObjectCopyWith<$R, Color, Color>> get colors =>
      ListCopyWith($value.colors, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(colors: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get symbols =>
      ListCopyWith($value.symbols, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(symbols: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get translatedColorNames => ListCopyWith(
          $value.translatedColorNames,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(translatedColorNames: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get translatedSymbols => ListCopyWith(
          $value.translatedSymbols,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(translatedSymbols: v));
  @override
  $R call(
          {int? id,
          String? name,
          String? translatedName,
          String? imageUrl,
          DateTime? foundationDate,
          String? godmotherSchool,
          List<String>? colorNames,
          List<Color>? colors,
          List<String>? symbols,
          SchoolLeague? league,
          SchoolDivision? currentDivision,
          int? divisionNumber,
          int? firstDivisionChampionships,
          String? country,
          String? leagueLocation,
          int? lastPosition,
          List<String>? translatedColorNames,
          List<String>? translatedSymbols,
          String? translatedGodmotherSchool,
          String? translatedLeagueLocation,
          String? translatedCountry,
          bool? isFavorite}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (translatedName != null) #translatedName: translatedName,
        if (imageUrl != null) #imageUrl: imageUrl,
        if (foundationDate != null) #foundationDate: foundationDate,
        if (godmotherSchool != null) #godmotherSchool: godmotherSchool,
        if (colorNames != null) #colorNames: colorNames,
        if (colors != null) #colors: colors,
        if (symbols != null) #symbols: symbols,
        if (league != null) #league: league,
        if (currentDivision != null) #currentDivision: currentDivision,
        if (divisionNumber != null) #divisionNumber: divisionNumber,
        if (firstDivisionChampionships != null)
          #firstDivisionChampionships: firstDivisionChampionships,
        if (country != null) #country: country,
        if (leagueLocation != null) #leagueLocation: leagueLocation,
        if (lastPosition != null) #lastPosition: lastPosition,
        if (translatedColorNames != null)
          #translatedColorNames: translatedColorNames,
        if (translatedSymbols != null) #translatedSymbols: translatedSymbols,
        if (translatedGodmotherSchool != null)
          #translatedGodmotherSchool: translatedGodmotherSchool,
        if (translatedLeagueLocation != null)
          #translatedLeagueLocation: translatedLeagueLocation,
        if (translatedCountry != null) #translatedCountry: translatedCountry,
        if (isFavorite != null) #isFavorite: isFavorite
      }));
  @override
  School $make(CopyWithData data) => School(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      translatedName: data.get(#translatedName, or: $value.translatedName),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      foundationDate: data.get(#foundationDate, or: $value.foundationDate),
      godmotherSchool: data.get(#godmotherSchool, or: $value.godmotherSchool),
      colorNames: data.get(#colorNames, or: $value.colorNames),
      colors: data.get(#colors, or: $value.colors),
      symbols: data.get(#symbols, or: $value.symbols),
      league: data.get(#league, or: $value.league),
      currentDivision: data.get(#currentDivision, or: $value.currentDivision),
      divisionNumber: data.get(#divisionNumber, or: $value.divisionNumber),
      firstDivisionChampionships: data.get(#firstDivisionChampionships,
          or: $value.firstDivisionChampionships),
      country: data.get(#country, or: $value.country),
      leagueLocation: data.get(#leagueLocation, or: $value.leagueLocation),
      lastPosition: data.get(#lastPosition, or: $value.lastPosition),
      translatedColorNames:
          data.get(#translatedColorNames, or: $value.translatedColorNames),
      translatedSymbols:
          data.get(#translatedSymbols, or: $value.translatedSymbols),
      translatedGodmotherSchool: data.get(#translatedGodmotherSchool,
          or: $value.translatedGodmotherSchool),
      translatedLeagueLocation: data.get(#translatedLeagueLocation,
          or: $value.translatedLeagueLocation),
      translatedCountry:
          data.get(#translatedCountry, or: $value.translatedCountry),
      isFavorite: data.get(#isFavorite, or: $value.isFavorite));

  @override
  SchoolCopyWith<$R2, School, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SchoolCopyWithImpl($value, $cast, t);
}
